resource "aws_s3_bucket" "snipeitterrastate" {
  bucket = var.bucket-name
  acl = "private"
  force_destroy = var.force_destroy

server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

 versioning {
    enabled = true
  }

  tags = {
    Name = var.bucket-name
    Description = "This bucket is used for storing terraform state."
    environment = var.environment
  }

}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.snipeitterrastate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}