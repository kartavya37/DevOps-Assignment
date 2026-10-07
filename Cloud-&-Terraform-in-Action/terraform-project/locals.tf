locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Session     = "19"
    ManagedBy   = "Terraform"
  }
}

# Data source: Terraform reads the list of availability zones. It does not create anything.
data "aws_availability_zones" "available" {
  state = "available"
}
