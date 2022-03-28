variable "env" {
  type        = string
  description = "Ambiente para o qual a instância será criada. Valores esparados para este são: \"qa\",\"sandbox\" ou \"prod\"."
  validation {
    condition = can(regex(
      "^(qa|sandbox|prod)$"
    , var.env))
    error_message = "Um valor válido deve ser informado para a variável \"env\" (ex.: qa | sandbox | prod)!"
  }
}

variable "name" {
  type        = string
  description = "Nome da instância."
}

variable "vpc_id" {
  type        = string
  description = "Id da VPC em que a instância será criada."
}

variable "public_subnet_id" {
  type        = string
  description = "Id da subnet pública aonde a instância será criada."
}

variable "key_name" {
  type        = string
  description = "(Opcional) Nome de um key-pair existente para ser utilizado para acesso à instância. Caso seja omitido, um novo key-pair será criado."
  default     = ""
}

variable "ssh_ip_cidr_blocks" {
  type        = list(string)
  description = "(Opcional) Lista de IPs que poderão acessar a instância via SSH."
  default     = []
}

variable "enable_http" {
  type        = bool
  description = "(Opcional) Habilita requisições na porta 80."
  default     = false
}

variable "alarm_mem_used_percent_threshold" {
  description = "Porcentagem limite da utilizacao de memoria da instancia EC2."
  type        = number
}

variable "alarm_cpuutilization_threshold" {
  description = "Porcentagem limite da utilizacao de CPU da instancia EC2."
  type        = number
}

variable "alarm_disk_used_threshold" {
  description = "Porcentagem limite da utilizacao do disco da instancia EC2."
  type        = number
}

variable "alarm_networkout_threshold" {
  description = "Limite absoluto em bytes da utilizacao do Network Out da instancia EC2."
  type        = number
}

variable "infra_alarm_sns_emails" {
  description = "(Opcional Lista de e-mails para receberem notificacoes de alarmes relacionados a infraestrutura."
  type        = list(string)
  default     = []
}

variable "slo_response_time_threshold" {
  description = "SLO - Limite para o tempo de resposta do webserver em microsegundos."
  type        = number
}

variable "slo_success_threshold" {
  description = "SLO - Limite da taxa de sucesso."
  type        = number
}

variable "slo_sns_emails" {
  description = "Lista de e-mails para receberem notificacoes de alarmes relacionados ao SLO."
  type        = list(string)
}


variable "sla_response_time_threshold" {
  description = "SLA - Limite para o tempo de resposta do webserver em microsegundos."
  type        = number
}

variable "sla_success_threshold" {
  description = "SLA - Limite da taxa de sucesso."
  type        = number
}

variable "sla_sns_emails" {
  description = "Lista de e-mails para receberem notificacoes de alarmes relacionados ao SLA."
  type        = list(string)
}
