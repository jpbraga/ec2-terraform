resource "aws_sns_topic" "sns_alarm_topic" {
  name = var.sns_name
  display_name = var.sns_display_name
}

resource "aws_sns_topic_subscription" "sns_alarm_email_target" {
  topic_arn = aws_sns_topic.sns_alarm_topic.arn
  protocol  = "email"
  endpoint = var.sns_emails[count.index]
  count = length(var.sns_emails)
}