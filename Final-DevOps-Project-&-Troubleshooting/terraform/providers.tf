# -----------------------------------------------------------------------------
# LOCAL EMULATOR SETTINGS (Moto server on http://localhost:4566)
# I have no AWS account. This project runs against the Moto AWS emulator, not real AWS.
# Moto keeps the resources in memory. No VPC, EKS cluster or EC2 instance starts for real.
#
# To use real AWS: remove the lines between "EMULATOR START" and "EMULATOR END",
# then configure your own credentials (for example "aws configure" or AWS SSO).
# CAUTION: A real EKS cluster, NAT gateway and EC2 nodes cost money every hour.
# Run "terraform destroy" when you finish.
# -----------------------------------------------------------------------------
provider "aws" {
  region = var.aws_region

  # EMULATOR START
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true

  endpoints {
    ec2 = "http://localhost:4566"
    ecr = "http://localhost:4566"
    eks = "http://localhost:4566"
    iam = "http://localhost:4566"
    kms = "http://localhost:4566"
    s3  = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
  # EMULATOR END

  # Terraform adds these tags to every resource that supports tags.
  default_tags {
    tags = local.common_tags
  }
}
