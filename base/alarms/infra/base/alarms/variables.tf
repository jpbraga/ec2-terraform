variable "instance_id" {
  type = string
}

variable "mem_used_percent_threshold" {
  type = number
}

variable "cpuutilization_threshold" {
  type = number
}

variable "disk_used_threshold" {
  type = number
}

variable "networkout_threshold" {
  type = number
}

variable "evaluation_periods" {
  type = number
}

variable "period" {
  type = number
}

variable "sns_topic_alarm_arn" {
  type = string
}

variable "sns_topic_ok_arn" {
  type = string
}
