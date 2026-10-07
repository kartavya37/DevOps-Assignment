# One customer managed KMS key for the project: EKS Secrets, S3 backups and ECR images.

resource "aws_kms_key" "main" {
  description             = "${local.name_prefix} encryption key (EKS secrets, S3 backups, ECR)"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "${local.name_prefix}-kms"
  }
}

resource "aws_kms_alias" "main" {
  name          = "alias/${local.name_prefix}"
  target_key_id = aws_kms_key.main.key_id
}
