variable "instance_id" {
  type = string
}

variable "alarm_intent" {
  type = string
}

variable "response_time_threshold" {
  type = number
}

variable "request_time_evaluation_periods" {
  type = number
}

variable "response_time_period" {
  type = number
}

variable "response_time_percentile" {
  type = string
}

variable "success_rate_evaluation_periods" {
  type = number
}

variable "success_threshold" {
  type = number
}

variable "success_rate_period" {
  type = number
}

variable "sns_topic_alarm_arn" {
  type = string
}

variable "sns_topic_ok_arn" {
  type = string
}
