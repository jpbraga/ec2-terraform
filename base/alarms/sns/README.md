<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic.sns_alarm_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.sns_alarm_email_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sns_display_name"></a> [sns\_display\_name](#input\_sns\_display\_name) | Nome de exibicao do topico SNS. | `string` | n/a | yes |
| <a name="input_sns_emails"></a> [sns\_emails](#input\_sns\_emails) | Lista de e-mails para notificacao. | `list(string)` | `[]` | no |
| <a name="input_sns_name"></a> [sns\_name](#input\_sns\_name) | Nome do recurso SNS. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | n/a |
##### Documento gerado utilizando "terraform-docs -c .terraform-docs.yml ."
<!-- END_TF_DOCS -->    