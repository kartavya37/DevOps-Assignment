variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.aws_region))
    error_message = "The region must look like us-east-1 or ap-south-1."
  }
}

variable "project_name" {
  description = "Short project name. Terraform uses it as a prefix in resource names."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,20}$", var.project_name))
    error_message = "The project name must start with a letter and have 3-21 lowercase letters, numbers or hyphens."
  }
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment must be dev, staging or prod."
  }
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC."
  type        = string
  default     = "10.20.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "The VPC CIDR must be a valid IPv4 CIDR block, for example 10.20.0.0/16."
  }
}

variable "public_subnet_cidr" {
  description = "CIDR block of the public subnet. It must be inside the VPC CIDR."
  type        = string
  default     = "10.20.1.0/24"

  validation {
    condition     = can(cidrhost(var.public_subnet_cidr, 0))
    error_message = "The subnet CIDR must be a valid IPv4 CIDR block, for example 10.20.1.0/24."
  }
}

variable "allowed_ssh_cidr" {
  description = "Only this CIDR block can connect to the EC2 instance on port 22."
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0)) && var.allowed_ssh_cidr != "0.0.0.0/0"
    error_message = "The SSH CIDR must be a valid CIDR block and must not be 0.0.0.0/0."
  }
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro", "t3.small"], var.instance_type)
    error_message = "The instance type must be t2.micro, t3.micro or t3.small (small and low cost)."
  }
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance."
  type        = string

  validation {
    condition     = can(regex("^ami-[0-9a-f]{8,17}$", var.ami_id))
    error_message = "The AMI ID must start with ami- and have 8 to 17 hexadecimal characters."
  }
}

variable "bucket_name" {
  description = "Globally unique name of the S3 bucket for application assets."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "The bucket name must have 3-63 characters: lowercase letters, numbers, dots and hyphens."
  }
}
