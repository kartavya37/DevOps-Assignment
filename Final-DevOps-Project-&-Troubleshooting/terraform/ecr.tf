# ECR repositories for the two images (an alternative to GHCR inside AWS).

resource "aws_ecr_repository" "app" {
  for_each = toset(["taskboard-backend", "taskboard-frontend"])

  name                 = "${var.project_name}/${each.key}"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true

  # ECR scans each pushed image for known vulnerabilities.
  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.main.arn
  }

  tags = {
    Name = each.key
  }
}

# Keep only the last 20 images in each repository.
resource "aws_ecr_lifecycle_policy" "app" {
  for_each   = aws_ecr_repository.app
  repository = each.value.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep the last 20 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 20
      }
      action = { type = "expire" }
    }]
  })
}
