# EKS cluster (control plane) and one managed node group in the private subnets.

resource "aws_eks_cluster" "main" {
  name     = local.cluster_name
  version  = var.kubernetes_version
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids              = concat(aws_subnet.private[*].id, aws_subnet.public[*].id)
    security_group_ids      = [aws_security_group.cluster.id]
    endpoint_private_access = true
    # The API endpoint is private by default. Set eks_public_endpoint = true only for a lab,
    # and then only the admin CIDR can reach it.
    endpoint_public_access = var.eks_public_endpoint
    public_access_cidrs    = var.eks_public_endpoint ? [var.admin_cidr] : null
  }

  # Encrypt Kubernetes Secrets in etcd with the project KMS key.
  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.main.arn
    }
  }

  # Send all control plane logs to CloudWatch (for troubleshooting and audit).
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # The role needs its policy before EKS can create the cluster.
  depends_on = [aws_iam_role_policy_attachment.cluster]

  tags = {
    Name = local.cluster_name
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${local.name_prefix}-nodes"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = aws_subnet.private[*].id
  instance_types  = var.node_instance_types
  capacity_type   = "ON_DEMAND"
  disk_size       = 20

  scaling_config {
    desired_size = var.node_desired_size
    min_size     = var.node_min_size
    max_size     = var.node_max_size
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    workload = "taskboard"
  }

  depends_on = [aws_iam_role_policy_attachment.nodes]

  tags = {
    Name = "${local.name_prefix}-nodes"
  }
}
