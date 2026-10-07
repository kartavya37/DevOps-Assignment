# S3 bucket for application assets.
resource "aws_s3_bucket" "assets" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_versioning" "assets" {
  bucket = aws_s3_bucket.assets.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "assets" {
  bucket = aws_s3_bucket.assets.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "assets" {
  bucket = aws_s3_bucket.assets.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# A small object that records the deployment. It uses values from other resources.
resource "aws_s3_object" "deployment_info" {
  bucket       = aws_s3_bucket.assets.id
  key          = "deployment/info.json"
  content_type = "application/json"

  content = jsonencode({
    project     = var.project_name
    environment = var.environment
    vpc_id      = aws_vpc.main.id
    instance_id = aws_instance.web.id
  })
}
