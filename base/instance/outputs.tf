output "instance_id" {
  value = element(aws_instance.ec2_web_server.*.id, 0)
}

output "public_key_s3_bucket_name" {
  value = var.key_name == "" ? aws_s3_bucket.public_key[0].bucket_domain_name : ""
}
