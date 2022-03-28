module "ec2_business_alarms" {
  source                          = "./base/alarms"
  instance_id                     = var.instance_id
  alarm_intent                    = var.alarm_intent
  response_time_threshold         = var.response_time_threshold
  request_time_evaluation_periods = var.request_time_evaluation_periods
  response_time_period            = var.response_time_period
  success_rate_evaluation_periods = var.success_rate_evaluation_periods
  success_threshold               = var.success_threshold
  success_rate_period             = var.success_rate_period
  response_time_percentile        = var.response_time_percentile
  sns_topic_alarm_arn             = module.sns_business_alarm.sns_topic_arn
  sns_topic_ok_arn                = module.sns_business_alarm.sns_topic_arn
  depends_on = [
    module.sns_business_alarm
  ]
}

module "sns_business_alarm" {
  source           = "../sns"
  sns_display_name = "Alarme de infra da instancia ${var.instance_id}"
  sns_name         = "Alarme_de_EC2_${var.instance_id}"
  sns_emails       = var.sns_emails
}
