<!-- BEGIN_TF_DOCS -->
# EC2 WebServer
## Objetivo

Este módulo realizará a criação dos seguintes itens:
* Uma instância EC2 para o ambiente informado ( qa, sandbox ou prod ).
* Instalação do Apache, configuração e exportação de logs e métricas para o cloudwatch.
* Chave de acesso publica disponibilizada em um S3 Bucket.
* Alarmes de infra estrutura para monitoramento da saúde da instância EC2.
* Alarmes de SLO e SLA do servico de web service.

## Metricas do WebServer
As seguintes métricas são exportadas utilizando o log metric filter do CloudWatch
* Erros 4XX (soma)
* Erros 5XX (soma)
* Requisicoes com sucesso (soma)
* Tempo de requisição em microsegundos

# Utilização
 ```hcl
module "ec2" {
 source                           = "../"
 env                              = "qa"
 name                             = "stone"
 vpc_id                           = "vpc-8e89d1f4"
 public_subnet_id                 = "subnet-51c41b1c"
 ssh_ip_cidr_blocks               = ["179.152.163.69/32"]
 alarm_mem_used_percent_threshold = "80"
 alarm_cpuutilization_threshold   = "65"
 alarm_disk_used_threshold        = "70"
 alarm_networkout_threshold       = "4800000000" #4.8Gb de 5Gb que uma instancia t2.micro possui
 infra_alarm_sns_emails           = ["jp.am.braga@gmail.com"]

 sla_response_time_threshold       = 500
 sla_success_threshold            = 95
 sla_sns_emails                   = ["jp.am.braga@gmail.com"]

 slo_response_time_threshold       = 300
 slo_success_threshold            = 99
 slo_sns_emails                   = ["jp.am.braga@gmail.com"]
}
 ```

# Obs:
* O serviço do apache será configurado para responder na porta 443 com um self-signed certificate e redirecionar o trafego da porta 80 para a 443. Para que o redirect possa funcionar corretamente o parametro enable\_http deve ser habilitado.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_alarms_sla"></a> [ec2\_alarms\_sla](#module\_ec2\_alarms\_sla) | ./base/alarms/apache | n/a |
| <a name="module_ec2_alarms_slo"></a> [ec2\_alarms\_slo](#module\_ec2\_alarms\_slo) | ./base/alarms/apache | n/a |
| <a name="module_ec2_infra_alarms"></a> [ec2\_infra\_alarms](#module\_ec2\_infra\_alarms) | ./base/alarms/infra | n/a |
| <a name="module_ec2_instance"></a> [ec2\_instance](#module\_ec2\_instance) | ./base/instance | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_cpuutilization_threshold"></a> [alarm\_cpuutilization\_threshold](#input\_alarm\_cpuutilization\_threshold) | Porcentagem limite da utilizacao de CPU da instancia EC2. | `number` | n/a | yes |
| <a name="input_alarm_disk_used_threshold"></a> [alarm\_disk\_used\_threshold](#input\_alarm\_disk\_used\_threshold) | Porcentagem limite da utilizacao do disco da instancia EC2. | `number` | n/a | yes |
| <a name="input_alarm_mem_used_percent_threshold"></a> [alarm\_mem\_used\_percent\_threshold](#input\_alarm\_mem\_used\_percent\_threshold) | Porcentagem limite da utilizacao de memoria da instancia EC2. | `number` | n/a | yes |
| <a name="input_alarm_networkout_threshold"></a> [alarm\_networkout\_threshold](#input\_alarm\_networkout\_threshold) | Limite absoluto em bytes da utilizacao do Network Out da instancia EC2. | `number` | n/a | yes |
| <a name="input_enable_http"></a> [enable\_http](#input\_enable\_http) | (Opcional) Habilita requisições na porta 80. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | Ambiente para o qual a instância será criada. Valores esparados para este são: "qa","sandbox" ou "prod". | `string` | n/a | yes |
| <a name="input_infra_alarm_sns_emails"></a> [infra\_alarm\_sns\_emails](#input\_infra\_alarm\_sns\_emails) | (Opcional Lista de e-mails para receberem notificacoes de alarmes relacionados a infraestrutura. | `list(string)` | `[]` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | (Opcional) Nome de um key-pair existente para ser utilizado para acesso à instância. Caso seja omitido, um novo key-pair será criado. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Nome da instância. | `string` | n/a | yes |
| <a name="input_public_subnet_id"></a> [public\_subnet\_id](#input\_public\_subnet\_id) | Id da subnet pública aonde a instância será criada. | `string` | n/a | yes |
| <a name="input_sla_response_time_threshold"></a> [sla\_response\_time\_threshold](#input\_sla\_response\_time\_threshold) | SLA - Limite para o tempo de resposta do webserver em microsegundos. | `number` | n/a | yes |
| <a name="input_sla_sns_emails"></a> [sla\_sns\_emails](#input\_sla\_sns\_emails) | Lista de e-mails para receberem notificacoes de alarmes relacionados ao SLA. | `list(string)` | n/a | yes |
| <a name="input_sla_success_threshold"></a> [sla\_success\_threshold](#input\_sla\_success\_threshold) | SLA - Limite da taxa de sucesso. | `number` | n/a | yes |
| <a name="input_slo_response_time_threshold"></a> [slo\_response\_time\_threshold](#input\_slo\_response\_time\_threshold) | SLO - Limite para o tempo de resposta do webserver em microsegundos. | `number` | n/a | yes |
| <a name="input_slo_sns_emails"></a> [slo\_sns\_emails](#input\_slo\_sns\_emails) | Lista de e-mails para receberem notificacoes de alarmes relacionados ao SLO. | `list(string)` | n/a | yes |
| <a name="input_slo_success_threshold"></a> [slo\_success\_threshold](#input\_slo\_success\_threshold) | SLO - Limite da taxa de sucesso. | `number` | n/a | yes |
| <a name="input_ssh_ip_cidr_blocks"></a> [ssh\_ip\_cidr\_blocks](#input\_ssh\_ip\_cidr\_blocks) | (Opcional) Lista de IPs que poderão acessar a instância via SSH. | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Id da VPC em que a instância será criada. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | Id da instância criada. |
| <a name="output_public_key_s3_bucket_name"></a> [public\_key\_s3\_bucket\_name](#output\_public\_key\_s3\_bucket\_name) | Bucket que contém a chave publica de acesso a instancia. Caso uma chave tenha sido informada, este output nao retornara valor. |
##### Documento gerado utilizando "terraform-docs -c .terraform-docs.yml ."
<!-- END_TF_DOCS -->    