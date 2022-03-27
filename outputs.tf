output "instance_id" {
  description = "Id da instância criada."
  value = module.ec2_instance.instance_id
}

output "public_key_s3_bucket_name" { 
  description = "Bucket que contém a chave publica de acesso a instancia. Caso uma chave tenha sido informada, este output nao retornara valor."
  value = module.ec2_instance.public_key_s3_bucket_name
}
