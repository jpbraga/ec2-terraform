//[date, client, request="GET /*", status_code, response_time]
resource "aws_cloudwatch_log_metric_filter" "apache_request_time" {
  name           = "ApacheAccessMetricsRequestTime"
  pattern        = "[date, client, request, status_code, response_time]"
  log_group_name = aws_cloudwatch_log_group.apache.name

  metric_transformation {
    name      = "ResponseTime"
    namespace = "Apache"
    value     = "$response_time"
    unit      = "Microseconds"
  }
}

resource "aws_cloudwatch_log_metric_filter" "apache_total_requests" {
  name           = "ApacheAccessMetricsTotalRequests"
  pattern        = "[date, client, request, status_code, response_time]"
  log_group_name = aws_cloudwatch_log_group.apache.name

  metric_transformation {
    name          = "TotalRequests"
    namespace     = "Apache"
    value         = 1
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "apache_successful_requests" {
  name           = "ApacheAccessMetricsSuccessfulRequests"
  pattern        = "[date, client, request, status_code=\"2*\" || status_code=\"3*\", response_time]"
  log_group_name = aws_cloudwatch_log_group.apache.name

  metric_transformation {
    name          = "SucessfulRequests"
    namespace     = "Apache"
    value         = 1
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "apache_5XX_requests" {
  name           = "ApacheAccessMetrics5XXRequests"
  pattern        = "[date, client, request, status_code=\"5*\", response_time]"
  log_group_name = aws_cloudwatch_log_group.apache.name

  metric_transformation {
    name          = "5XX"
    namespace     = "Apache"
    value         = 1
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "apache_4XX_requests" {
  name           = "ApacheAccessMetrics4XXRequests"
  pattern        = "[date, client, request, status_code=\"4*\", response_time]"
  log_group_name = aws_cloudwatch_log_group.apache.name

  metric_transformation {
    name          = "4XX"
    namespace     = "Apache"
    value         = 1
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_group" "apache" {
  name = "apache-webserver"
}
