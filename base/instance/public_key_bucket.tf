resource "aws_s3_bucket" "public_key" {
  count  = var.key_name == "" ? 1 : 0
  bucket = "${var.name}-${var.env}-instance-key-pair-bucket"
}

resource "aws_s3_bucket_acl" "public_key_bycket_acl" {
  count  = var.key_name == "" ? 1 : 0
  bucket = aws_s3_bucket.public_key[0].id
  acl    = "private"
}
