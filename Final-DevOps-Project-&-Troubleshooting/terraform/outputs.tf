output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets (EKS nodes)."
  value       = aws_subnet.private[*].id
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  description = "Kubernetes API endpoint of the EKS cluster."
  value       = aws_eks_cluster.main.endpoint
}

output "eks_node_group_status" {
  description = "Status of the managed node group."
  value       = aws_eks_node_group.main.status
}

output "ecr_repository_urls" {
  description = "Push URLs of the ECR repositories."
  value       = { for k, r in aws_ecr_repository.app : k => r.repository_url }
}

output "kms_key_arn" {
  description = "ARN of the project KMS key."
  value       = aws_kms_key.main.arn
}

output "backup_bucket" {
  description = "Name of the S3 bucket for database backups."
  value       = aws_s3_bucket.backups.bucket
}

output "configure_kubectl" {
  description = "Command that adds the cluster to your kubeconfig (real AWS only)."
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${aws_eks_cluster.main.name}"
}
