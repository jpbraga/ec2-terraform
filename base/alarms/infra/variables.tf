variable "instance_id" {
  description = "Id da instancia EC2."
  type = string
}

variable "mem_used_percent_threshold" {
  description = "Porcentagem limite da utilizacao de memoria da instancia EC2."
  type = number
}

variable "cpuutilization_threshold" {
  description = "Porcentagem limite da utilizacao de CPU da instancia EC2."
  type = number
}

variable "disk_used_threshold" {
  description = "Porcentagem limite da utilizacao do disco da instancia EC2."
  type = number
}

variable "networkout_threshold" {
  description = "Limite absoluto em bytes da utilizacao do Network Out da instancia EC2."
  type = number
}

variable "evaluation_periods" {
  description = "(Opcional) Quantidade de periodos de avaliacao das metricas de infraestrutura."
  type    = number
  default = 3
}

variable "period" {
  description = "(Opcional) Tamanho do periodo para avaliacao das metricas de infraestrutura."
  type    = number
  default = 60
}

variable "sns_emails" {
  description = "(Opcional) Lista de e-mails para notificacao de alarmes de infraestrutura."
  type    = list(string)
  default = []
}
