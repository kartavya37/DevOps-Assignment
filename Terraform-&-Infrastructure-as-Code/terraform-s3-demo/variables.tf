variable "aws_region" {
  description = "AWS region for the S3 bucket."
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique name of the S3 bucket."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "The bucket name must have 3-63 characters: lowercase letters, numbers, dots and hyphens."
  }
}

variable "environment" {
  description = "Environment name for the tags."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment must be dev, staging or prod."
  }
}

variable "versioning_enabled" {
  description = "If true, S3 keeps all versions of each object."
  type        = bool
  default     = true
}
