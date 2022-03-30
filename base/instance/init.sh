#!/bin/bash
sudo yum update -y
sudo yum install -y amazon-linux-extras
sudo yum install -y httpd httpd-tools mod_ssl 

echo "Overriding the default Apache page to eliminate 403 erros..."
sudo touch /var/www/html/index.html
sudo chmod -R 777 /var/www/html/index.html
cat <<"EOF" >/var/www/html/index.html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title>Test Page for the Apache HTTP Server</title>
	</head>
	<body>
		<h1>It works!</h1>
		<div class="content">
			<div class="content-middle">
				<p>This page is used to test the proper operation of the Apache HTTP server after it has been installed. If you can read this page, it means that the Apache HTTP server installed at this site is working properly.</p>
			</div>
		</div>
	</body>
</html>
EOF

echo "Getting instance hostname from metadata..."
HOSTNAME=$(curl -s  http://169.254.169.254/latest/meta-data/public-hostname)

echo "Generate CA private key"
sudo openssl genrsa -out ca.key 2048

echo "Generate CSR"
sudo openssl req -new -key ca.key -out ca.csr -subj "/C=BR/ST=SP/L=SP/O=stone/OU=TI/CN=${HOSTNAME}"

echo "Generate Certificate"
sudo openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt

echo "Copying certificates to the pki folders..."
sudo cp ca.crt /etc/pki/tls/certs
sudo cp ca.key /etc/pki/tls/private/ca.key
sudo cp ca.csr /etc/pki/tls/private/ca.csr

echo "Configuring ssl, redirect and log format..."
sudo chmod 777 /etc/httpd/conf.d/ssl.conf
cat <<EOF > /etc/httpd/conf.d/ssl.conf
Listen 443 https
SSLPassPhraseDialog exec:/usr/libexec/httpd-ssl-pass-dialog
SSLSessionCache         shmcb:/run/httpd/sslcache(512000)
SSLSessionCacheTimeout  300
SSLRandomSeed startup file:/dev/urandom  256
SSLRandomSeed connect builtin
SSLCryptoDevice builtin

NameVirtualHost *:80
<VirtualHost *:80>
	ServerName ${HOSTNAME}
   	Redirect / https://${HOSTNAME}
</VirtualHost>

<VirtualHost _default_:443>

ServerName ${HOSTNAME}

ErrorLog logs/ssl_error_log
TransferLog logs/ssl_access_log
LogLevel warn
SSLEngine on
SSLProtocol all -SSLv3
SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5:!SEED:!IDEA
SSLCertificateFile /etc/pki/tls/certs/ca.crt
SSLCertificateKeyFile /etc/pki/tls/private/ca.key
<Files ~ "\.(cgi|shtml|phtml|php3?)$">
    SSLOptions +StdEnvVars
</Files>
<Directory "/var/www/cgi-bin">
    SSLOptions +StdEnvVars
</Directory>
BrowserMatch "MSIE [2-5]" \
	nokeepalive ssl-unclean-shutdown \
	downgrade-1.0 force-response-1.0
EOF

cat <<"EOF" >> /etc/httpd/conf.d/ssl.conf
CustomLog logs/ssl_request_log \
	"%t %a \"%r\" %>s %D"

</VirtualHost>
EOF

echo "Starting apache..."
sudo systemctl start httpd

echo "Enabling apache service to start at instance reboot..."
sudo systemctl enable httpd 

echo "Installing Cloudwatch agent..."
sudo yum install -y amazon-cloudwatch-agent

echo "Installing collectd to collect memory metrics from the EC2 instance..."
sudo amazon-linux-extras install -y collectd

sudo touch /opt/aws/amazon-cloudwatch-agent/etc/config.json
sudo chmod -R 777 /opt/aws/amazon-cloudwatch-agent/etc/config.json
cat <<"EOF" >>/opt/aws/amazon-cloudwatch-agent/etc/config.json
{
	"agent": {
		"metrics_collection_interval": 60,
		"run_as_user": "root"
	},
	"logs": {
		"logs_collected": {
			"files": {
				"collect_list": [
					{
						"file_path": "/var/log/httpd/ssl_access_log",
						"log_group_name": "apache-webserver",
						"log_stream_name": "{instance_id}",
						"retention_in_days": 7
					}
				]
			}
		}
	},
	"metrics": {
		"aggregation_dimensions": [
			[
				"InstanceId"
			]
		],
		"append_dimensions": {
			"AutoScalingGroupName": "${aws:AutoScalingGroupName}",
			"ImageId": "${aws:ImageId}",
			"InstanceId": "${aws:InstanceId}",
			"InstanceType": "${aws:InstanceType}"
		},
		"metrics_collected": {
			"collectd": {
				"metrics_aggregation_interval": 60
			},
			"cpu": {
				"measurement": [
					"cpu_usage_idle",
					"cpu_usage_iowait",
					"cpu_usage_user",
					"cpu_usage_system"
				],
				"metrics_collection_interval": 60,
				"resources": [
					"*"
				],
				"totalcpu": false
			},
			"disk": {
				"measurement": [
					"used_percent",
					"inodes_free"
				],
				"metrics_collection_interval": 60,
				"resources": [
					"*"
				]
			},
			"diskio": {
				"measurement": [
					"io_time"
				],
				"metrics_collection_interval": 60,
				"resources": [
					"*"
				]
			},
			"mem": {
				"measurement": [
					"mem_used_percent"
				],
				"metrics_collection_interval": 60
			},
			"statsd": {
				"metrics_aggregation_interval": 60,
				"metrics_collection_interval": 10,
				"service_address": ":8125"
			},
			"swap": {
				"measurement": [
					"swap_used_percent"
				],
				"metrics_collection_interval": 60
			}
		}
	}
}
EOF
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/config.json -s
