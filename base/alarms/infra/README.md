<!-- BEGIN_TF_DOCS -->


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_infra_alarms"></a> [ec2\_infra\_alarms](#module\_ec2\_infra\_alarms) | ./base/alarms | n/a |
| <a name="module_sns_infra_alarm"></a> [sns\_infra\_alarm](#module\_sns\_infra\_alarm) | ../sns | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpuutilization_threshold"></a> [cpuutilization\_threshold](#input\_cpuutilization\_threshold) | Porcentagem limite da utilizacao de CPU da instancia EC2. | `number` | n/a | yes |
| <a name="input_disk_used_threshold"></a> [disk\_used\_threshold](#input\_disk\_used\_threshold) | Porcentagem limite da utilizacao do disco da instancia EC2. | `number` | n/a | yes |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | (Opcional) Quantidade de periodos de avaliacao das metricas de infraestrutura. | `number` | `3` | no |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | Id da instancia EC2. | `string` | n/a | yes |
| <a name="input_mem_used_percent_threshold"></a> [mem\_used\_percent\_threshold](#input\_mem\_used\_percent\_threshold) | Porcentagem limite da utilizacao de memoria da instancia EC2. | `number` | n/a | yes |
| <a name="input_networkout_threshold"></a> [networkout\_threshold](#input\_networkout\_threshold) | Limite absoluto em bytes da utilizacao do Network Out da instancia EC2. | `number` | n/a | yes |
| <a name="input_period"></a> [period](#input\_period) | (Opcional) Tamanho do periodo para avaliacao das metricas de infraestrutura. | `number` | `60` | no |
| <a name="input_sns_emails"></a> [sns\_emails](#input\_sns\_emails) | (Opcional) Lista de e-mails para notificacao de alarmes de infraestrutura. | `list(string)` | `[]` | no |
##### Documento gerado utilizando "terraform-docs -c .terraform-docs.yml ."
<!-- END_TF_DOCS -->    