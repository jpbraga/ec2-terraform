resource "aws_cloudwatch_metric_alarm" "apache_request_time_alarm" {
  alarm_name          = "apache-${var.alarm_intent}-response-time-maior-${var.response_time_threshold}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.request_time_evaluation_periods
  metric_name         = "ResponseTime"
  namespace           = "Apache"
  period              = var.response_time_period
  extended_statistic  = var.response_time_percentile
  threshold           = var.response_time_threshold
  alarm_description   = "${var.alarm_intent} - Tempo de resposta acima de ${var.response_time_threshold}"
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "apache_request_success_rate_alarm" {
  alarm_name                = "apache-${var.alarm_intent}-request-success-rate-alarm"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = var.success_rate_evaluation_periods
  threshold                 = var.success_threshold
  alarm_description         = "${var.alarm_intent} - Taxa de sucesso menor que ${var.success_threshold}%"
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  metric_query {
    id          = "e1"
    expression  = "(m2/m1) * 100"
    label       = "SuccessRate"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "false"
    metric {
      metric_name = "TotalRequests"
      namespace   = "Apache"
      period      = var.success_rate_period
      stat        = "Sum"
      unit        = "Count"
    }
  }

  metric_query {
    id          = "m2"
    return_data = "false"
    metric {
      metric_name = "SucessfulRequests"
      namespace   = "Apache"
      period      = var.success_rate_period
      stat        = "Sum"
      unit        = "Count"
    }
  }
}

resource "aws_cloudwatch_composite_alarm" "ec2_composite_alarm" {
  alarm_description = "Alarme de ${var.alarm_intent} da instância ec2 ${var.instance_id}"
  alarm_name        = "ec2-${var.alarm_intent}-${var.instance_id}-composite-alarm"

  alarm_actions = [var.sns_topic_alarm_arn]
  ok_actions    = [var.sns_topic_ok_arn]

  alarm_rule = "ALARM(${aws_cloudwatch_metric_alarm.apache_request_time_alarm.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.apache_request_success_rate_alarm.alarm_name})"
  depends_on = [
    aws_cloudwatch_metric_alarm.apache_request_time_alarm,
    aws_cloudwatch_metric_alarm.apache_request_success_rate_alarm,
  ]
}
