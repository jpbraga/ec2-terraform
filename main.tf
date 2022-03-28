/**
 * # EC2 WebServer
 * ## Objetivo
 *
 * Este módulo realizará a criação dos seguintes itens:
 * * Uma instância EC2 para o ambiente informado ( qa, sandbox ou prod ).
 * * Instalação do Apache, configuração e exportação de logs e métricas para o cloudwatch.
 * * Chave de acesso publica disponibilizada em um S3 Bucket.
 * * Alarmes de infra estrutura para monitoramento da saúde da instância EC2.
 * * Alarmes de SLO e SLA do servico de web service.
 *
 * ## Metricas do WebServer
 * As seguintes métricas são exportadas utilizando o log metric filter do CloudWatch
 * * Erros 4XX (soma)
 * * Erros 5XX (soma)
 * * Requisicoes com sucesso (soma)
 * * Tempo de requisição em microsegundos
 *
 * # Utilização
 *  ```hcl
 * module "ec2" {
 *  source                           = "../"
 *  env                              = "qa"
 *  name                             = "stone"
 *  vpc_id                           = "vpc-8e89d1f4"
 *  public_subnet_id                 = "subnet-51c41b1c"
 *  ssh_ip_cidr_blocks               = ["179.152.163.69/32"]
 *  alarm_mem_used_percent_threshold = "80"
 *  alarm_cpuutilization_threshold   = "65"
 *  alarm_disk_used_threshold        = "70"
 *  alarm_networkout_threshold       = "4800000000" #4.8Gb de 5Gb que uma instancia t2.micro possui
 *  infra_alarm_sns_emails           = ["jp.am.braga@gmail.com"]
 *
 *  sla_response_time_threshold       = 500
 *  sla_success_threshold            = 95
 *  sla_sns_emails                   = ["jp.am.braga@gmail.com"]
 * 
 *  slo_response_time_threshold       = 300
 *  slo_success_threshold            = 99
 *  slo_sns_emails                   = ["jp.am.braga@gmail.com"]
 * }
 *  ```
 *
 * # Obs:
 * * Após o setup inicial um ami pode ser feito a partir da instância EC2 criada por este terraform e utilizado como imagem base para a instância eliminando assim o tempo de startup.
 */

module "ec2_instance" {
  source             = "./base/instance"
  name               = var.name
  vpc_id             = var.vpc_id
  public_subnet_id   = var.public_subnet_id
  ssh_ip_cidr_blocks = var.ssh_ip_cidr_blocks
  env                = var.env
  key_name           = var.key_name
  enable_http        = var.enable_http
}

module "ec2_infra_alarms" {
  source                     = "./base/alarms/infra"
  instance_id                = module.ec2_instance.instance_id
  mem_used_percent_threshold = var.alarm_mem_used_percent_threshold
  cpuutilization_threshold   = var.alarm_cpuutilization_threshold
  disk_used_threshold        = var.alarm_disk_used_threshold
  networkout_threshold       = var.alarm_networkout_threshold
  sns_emails                 = var.infra_alarm_sns_emails
  depends_on = [
    module.ec2_instance
  ]
}

module "ec2_alarms_slo" {
  source                 = "./base/alarms/apache"
  instance_id            = module.ec2_instance.instance_id
  alarm_intent           = "SLO"
  response_time_threshold = var.slo_response_time_threshold
  success_threshold      = var.slo_success_threshold
  sns_emails             = var.slo_sns_emails
}

module "ec2_alarms_sla" {
  source                 = "./base/alarms/apache"
  instance_id            = module.ec2_instance.instance_id
  alarm_intent           = "SLA"
  response_time_threshold = var.sla_response_time_threshold
  success_threshold      = var.sla_success_threshold
  sns_emails             = var.sla_sns_emails
}