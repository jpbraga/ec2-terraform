variable "instance_id" {
  description = "Identificador da instancia ec2."
  type = string
}

variable "alarm_intent" {
  description = "Finalidade do alarme de negócio (ex: SLO, SLA)"
  type = string
}

variable "response_time_threshold" {
  description = "Limite para o tempo de resposta do webserver em microsegundos."
  type = number
}

variable "request_time_evaluation_periods" {
  description = "(Opcional) Quantidade de períodos de avaliação para o tempo de resposta do servidor."
  type = number
  default = 1
}

variable "response_time_period" {
  description = "(Opcional) Tamanho do período de avaliação para o tempo de resposta do servidor (em segundos)."
  type = number
  default = 900
}

variable "success_rate_evaluation_periods" {
  description = "Quantidade de periodos para avaliacao da taxa de sucesso."
  type = number
  default = 1
}

variable "success_threshold" {
  description = "Limite da taxa de sucesso."
  type = number
}

variable "success_rate_period" {
  description = "(Opcional) Tamanho do período de avaliação para a taxa de sucesso (em segundos)."
  type = number
  default = 900
}

variable "response_time_percentile" {
  description = "(Opcional) Percentil para o monitoramento do tempo de resposta."
  type        = string
  default     = "p95"
}

variable "sns_emails" {
  description = "(Opcional) Lista de e-mails para notificacao de alarmes de negocio."
  type        = list(string)
  default     = []
}
