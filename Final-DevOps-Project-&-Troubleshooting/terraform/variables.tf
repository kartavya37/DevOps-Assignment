variable "project_name" {
  description = "Short name of the project. Terraform uses it in resource names."
  type        = string
  default     = "taskboard"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment must be dev, staging or prod."
  }
}

variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC."
  type        = string
  default     = "10.21.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks of the public subnets (one for each availability zone). Load balancers use them."
  type        = list(string)
  default     = ["10.21.0.0/24", "10.21.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks of the private subnets (one for each availability zone). The EKS nodes use them."
  type        = list(string)
  default     = ["10.21.10.0/24", "10.21.11.0/24"]
}

variable "kubernetes_version" {
  description = "Kubernetes version of the EKS control plane."
  type        = string
  default     = "1.33"
}

variable "node_instance_types" {
  description = "EC2 instance types of the EKS managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Number of worker nodes that the node group starts with."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 4
}

variable "eks_public_endpoint" {
  description = "Make the EKS API endpoint public (only for the admin CIDR). Keep false for production."
  type        = bool
  default     = false
}

variable "admin_cidr" {
  description = "CIDR block that can reach the EKS API endpoint. Use your own public IP address with /32."
  type        = string
  default     = "203.0.113.10/32"
}

variable "backup_retention_days" {
  description = "Days that S3 keeps database backups before it deletes them."
  type        = number
  default     = 30
}
