locals {
  name_prefix  = "${var.project_name}-${var.environment}"
  cluster_name = "${local.name_prefix}-eks"
  azs          = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnet_cidrs))

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = "kartavya-panchal"
    Session     = "21-final-project"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
