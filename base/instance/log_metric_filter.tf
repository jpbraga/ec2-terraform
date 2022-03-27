//[date, client, request="GET /*", status_code, response_time]
resource "aws_cloudwatch_log_metric_filter" "nginx_request_time" {
  name           = "NginxAccessMetricsRequestTime"
  pattern        = "[date, client, request, status_code, response_time]"
  log_group_name = aws_cloudwatch_log_group.nginx.name

  metric_transformation {
    name      = "ResponseTime"
    namespace = "Nginx"
    value     = "$response_time"
    unit      = "Microseconds"
  }
}

resource "aws_cloudwatch_log_metric_filter" "nginx_total_requests" {
  name           = "NginxAccessMetricsTotalRequests"
  pattern        = "[date, client, request, status_code, response_time]"
  log_group_name = aws_cloudwatch_log_group.nginx.name

  metric_transformation {
    name          = "TotalRequests"
    namespace     = "Nginx"
    value         = 1
    default_value = 0
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "nginx_successful_requests" {
  name           = "NginxAccessMetricsSuccessfulRequests"
  pattern        = "[date, client, request, status_code=\"2*\" || status_code=\"3*\", response_time]"
  log_group_name = aws_cloudwatch_log_group.nginx.name

  metric_transformation {
    name          = "SucessfulRequests"
    namespace     = "Nginx"
    value         = 1
    default_value = 0
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "nginx_5XX_requests" {
  name           = "NginxAccessMetrics5XXRequests"
  pattern        = "[date, client, request, status_code=\"5*\", response_time]"
  log_group_name = aws_cloudwatch_log_group.nginx.name

  metric_transformation {
    name          = "5XX"
    namespace     = "Nginx"
    value         = 1
    default_value = 0
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "nginx_4XX_requests" {
  name           = "NginxAccessMetrics4XXRequests"
  pattern        = "[date, client, request, status_code=\"4*\", response_time]"
  log_group_name = aws_cloudwatch_log_group.nginx.name

  metric_transformation {
    name          = "4XX"
    namespace     = "Nginx"
    value         = 1
    default_value = 0
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_group" "nginx" {
  # name = "nginx-webserver/${element(aws_instance.ec2_web_server.*.id, 0)}"
  name = "nginx-webserver"
}
