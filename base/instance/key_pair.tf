resource "tls_private_key" "tls" {
  count     = var.key_name == "" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_s3_object" "tls_key_bucket_object" {
  count   = var.key_name == "" ? 1 : 0
  key     = "${local.key_pair_name}.pem"
  bucket  = aws_s3_bucket.public_key[0].id
  content = tls_private_key.tls[0].private_key_pem
}

resource "aws_key_pair" "aws_key_pair" {
  count      = var.key_name == "" ? 1 : 0
  key_name   = local.key_pair_name
  public_key = tls_private_key.tls[0].public_key_openssh
}
