resource "aws_cloudwatch_metric_alarm" "nginx_request_time_alarm" {
  alarm_name          = "nginx-${var.application_name}-response-time-maior-${var.reponse_time_threshold}%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "ReponseTime"
  namespace           = "Nginx"
  period              = var.respose_time_period
  statistic           = var.reponse_time_percentile
  threshold           = var.reponse_time_threshold
  alarm_description   = "${var.application_name} - Tempo de resposta acima de ${var.reponse_time_threshold}%"
  treat_missing_data  = "notBreaching"

  dimensions = {
    "InstanceId" = var.instance_id
  }
}


resource "aws_cloudwatch_metric_alarm" "nginx_request_success_rate_alarm" {
  alarm_name                = "nginx-${var.application_name}-request-success-rate-alarm"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "2"
  threshold                 = var.success_threshold
  alarm_description         = "Alarme de Throttling de leitura para ${var.application_name} maior que ${var.success_threshold}%"
  treat_missing_data        = "ignore"
  # alarm_actions             = [var.sns_topic_alarm_arn]
  # ok_actions                = [var.sns_topic_ok_arn]
  insufficient_data_actions = []

  metric_query {
    id          = "e1"
    expression  = "(m1/m2) * 100"
    label       = "ReadThrottlesOverTotalReads"
    return_data = "true"
  }

  metric_query {
    id = "m1"
    return_data = "false"
    metric {
      metric_name = "TotalRequests"
      namespace   = "Nginx"
      period      = "60"
      stat        = "SampleCount"
      unit        = "Count"

      dimensions = {
        "TableName" = var.dynamodb_table_name
      }
    }
  }

  metric_query {
    id = "m2"
    return_data = "false"
    metric {
      metric_name = "ConsumedReadCapacityUnits"
      namespace   = "AWS/DynamoDB"
      period      = "60"
      stat        = "SampleCount"
      unit        = "Count"

      dimensions = {
        "TableName" = var.dynamodb_table_name
      }
    }
  }
}