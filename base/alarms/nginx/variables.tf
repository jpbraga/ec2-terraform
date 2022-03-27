variable "mem_used_percent_threshold" {
  description = "Porcentagem limite da utilizacao de memoria da instancia EC2."
  type        = number
}

variable "cpuutilization_threshold" {
  description = "Porcentagem limite da utilizacao de CPU da instancia EC2."
  type        = number
}

variable "disk_used_threshold" {
  description = "Porcentagem limite da utilizacao do disco da instancia EC2."
  type        = number
}

variable "networkout_threshold" {
  description = "Limite absoluto em bytes da utilizacao do Network Out da instancia EC2."
  type        = number
}

variable "evaluation_periods" {
  description = "(Opcional) Quantidade de periodos de avaliacao das metricas de negocio."
  type        = number
  default     = 1
}

variable "reponse_time_percentile" {
  description = "(Opcional) Percentil para o monitoramento do tempo de resposta."
  type        = string
  default     = "p95"
}

variable "response_time_period" {
  description = "(Opcional) Tamanho do periodo para avaliacao das metricas de negocio."
  type        = number
  default     = 900
}

variable "sns_emails" {
  description = "(Opcional) Lista de e-mails para notificacao de alarmes de negocio."
  type        = list(string)
  default     = []
}
