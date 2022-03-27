variable "sns_display_name" {
  description = "Nome de exibicao do topico SNS."
  type        = string
}

variable "sns_name" {
  description = "Nome do recurso SNS."
  type        = string
}

variable "sns_emails" {
  description = "Lista de e-mails para notificacao."
  type        = list(string)
  default     = []
}

