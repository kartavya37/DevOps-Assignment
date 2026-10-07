terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# -----------------------------------------------------------------------------
# LOCAL EMULATOR SETTINGS (Moto server on http://localhost:4566)
# This project runs against a local AWS emulator, not a real AWS account.
# To use real AWS: remove the lines between "EMULATOR START" and "EMULATOR END",
# then run "aws configure" so that Terraform uses your own credentials.
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
    s3  = "http://localhost:4566"
    sts = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
  # EMULATOR END

  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Project   = "Session18"
    }
  }
}
