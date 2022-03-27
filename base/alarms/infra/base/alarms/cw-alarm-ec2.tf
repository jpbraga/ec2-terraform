resource "aws_cloudwatch_metric_alarm" "ec2_memory_alarm" {
  alarm_name          = "ec2-${var.instance_id}-memoria-acima-${var.mem_used_percent_threshold}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = var.period
  statistic           = "Average"
  threshold           = var.mem_used_percent_threshold
  alarm_description   = "${var.instance_id} - Utilizacao de memoria acima de ${var.mem_used_percent_threshold}%"
  treat_missing_data  = "notBreaching"
  dimensions = {
    "InstanceId" = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_alarm" {
  alarm_name          = "ec2-${var.instance_id}-cpu-acima-${var.cpuutilization_threshold}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.period
  statistic           = "Average"
  threshold           = var.cpuutilization_threshold
  alarm_description   = "${var.instance_id} - Utilizacao de cpu acima de ${var.cpuutilization_threshold}%"
  treat_missing_data  = "notBreaching"

  dimensions = {
    "InstanceId" = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_network_alarm" {
  alarm_name          = "ec2-${var.instance_id}-network-out-acima-${var.networkout_threshold}-bytes"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = var.period
  statistic           = "Sum"
  threshold           = var.networkout_threshold
  alarm_description   = "${var.instance_id} - Network out acima de ${var.networkout_threshold}%"
  treat_missing_data  = "notBreaching"

  dimensions = {
    "InstanceId" = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_disk_alarm" {
  alarm_name          = "ec2-${var.instance_id}-utilizacao-disco-acima-de-${var.disk_used_threshold}%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = var.period
  statistic           = "Maximum"
  threshold           = var.disk_used_threshold
  alarm_description   = "${var.instance_id} - Network out acima de ${var.disk_used_threshold}%"
  treat_missing_data  = "notBreaching"

  dimensions = {
    "InstanceId" = var.instance_id
  }
}

resource "aws_cloudwatch_composite_alarm" "alb_composite_alarm" {
  alarm_description = "Alarme de utilizacao de infra para a instância ec2 ${var.instance_id}"
  alarm_name        = "ec2-${var.instance_id}-composite-alarm"

  alarm_actions = [var.sns_topic_alarm_arn]
  ok_actions    = [var.sns_topic_ok_arn]

  alarm_rule = "ALARM(${aws_cloudwatch_metric_alarm.ec2_memory_alarm.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.ec2_cpu_alarm.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.ec2_network_alarm.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.ec2_disk_alarm.alarm_name})"
  depends_on = [
    aws_cloudwatch_metric_alarm.ec2_memory_alarm,
    aws_cloudwatch_metric_alarm.ec2_cpu_alarm,
    aws_cloudwatch_metric_alarm.ec2_network_alarm,
    aws_cloudwatch_metric_alarm.ec2_disk_alarm
  ]
}
