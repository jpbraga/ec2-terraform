<!-- BEGIN_TF_DOCS -->


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_business_alarms"></a> [ec2\_business\_alarms](#module\_ec2\_business\_alarms) | ./base/alarms | n/a |
| <a name="module_sns_business_alarm"></a> [sns\_business\_alarm](#module\_sns\_business\_alarm) | ../sns | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_intent"></a> [alarm\_intent](#input\_alarm\_intent) | Finalidade do alarme de negócio (ex: SLO, SLA) | `string` | n/a | yes |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | Identificador da instancia ec2. | `string` | n/a | yes |
| <a name="input_request_time_evaluation_periods"></a> [request\_time\_evaluation\_periods](#input\_request\_time\_evaluation\_periods) | (Opcional) Quantidade de períodos de avaliação para o tempo de resposta do servidor. | `number` | `1` | no |
| <a name="input_response_time_period"></a> [response\_time\_period](#input\_response\_time\_period) | (Opcional) Tamanho do período de avaliação para o tempo de resposta do servidor (em segundos). | `number` | `900` | no |
| <a name="input_response_time_statistic"></a> [response\_time\_statistic](#input\_response\_time\_statistic) | (Opcional) Estatistica para o monitoramento do tempo de resposta. | `string` | `"SampleCount"` | no |
| <a name="input_response_time_threshold"></a> [response\_time\_threshold](#input\_response\_time\_threshold) | Limite para o tempo de resposta do webserver em microsegundos. | `number` | n/a | yes |
| <a name="input_sns_emails"></a> [sns\_emails](#input\_sns\_emails) | (Opcional) Lista de e-mails para notificacao de alarmes de negocio. | `list(string)` | `[]` | no |
| <a name="input_success_rate_evaluation_periods"></a> [success\_rate\_evaluation\_periods](#input\_success\_rate\_evaluation\_periods) | Quantidade de periodos para avaliacao da taxa de sucesso. | `number` | `1` | no |
| <a name="input_success_rate_period"></a> [success\_rate\_period](#input\_success\_rate\_period) | (Opcional) Tamanho do período de avaliação para a taxa de sucesso (em segundos). | `number` | `900` | no |
| <a name="input_success_threshold"></a> [success\_threshold](#input\_success\_threshold) | Limite da taxa de sucesso. | `number` | n/a | yes |
##### Documento gerado utilizando "terraform-docs -c .terraform-docs.yml ."
<!-- END_TF_DOCS -->    