module "ec2_infra_alarms" {
  source                     = "./base/alarms"
  instance_id                = var.instance_id
  mem_used_percent_threshold = var.mem_used_percent_threshold
  cpuutilization_threshold   = var.cpuutilization_threshold
  disk_used_threshold        = var.disk_used_threshold
  networkout_threshold       = var.networkout_threshold
  evaluation_periods         = var.evaluation_periods
  period                     = var.period
  sns_topic_alarm_arn        = module.sns_infra_alarm.sns_topic_arn
  sns_topic_ok_arn           = module.sns_infra_alarm.sns_topic_arn
  depends_on = [
    module.sns_infra_alarm
  ]
}

module "sns_infra_alarm" {
  source           = "../sns"
  sns_display_name = "Alarme de infra da instancia ${var.instance_id}"
  sns_name         = "Alarme_de_EC2_${var.instance_id}"
  sns_emails       = var.sns_emails
}
