# Security groups.
#   cluster SG: the EKS control plane. HTTPS (443) from the admin CIDR and from the nodes.
#   nodes SG:   the worker nodes. All traffic between nodes, 443/10250 from the control plane.

resource "aws_security_group" "cluster" {
  name        = "${local.name_prefix}-eks-cluster-sg"
  description = "EKS control plane"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${local.name_prefix}-eks-cluster-sg"
  }
}

resource "aws_security_group" "nodes" {
  name        = "${local.name_prefix}-eks-nodes-sg"
  description = "EKS worker nodes"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name                                          = "${local.name_prefix}-eks-nodes-sg"
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }
}

resource "aws_vpc_security_group_ingress_rule" "cluster_api_from_admin" {
  security_group_id = aws_security_group.cluster.id
  description       = "Kubernetes API from the admin CIDR"
  cidr_ipv4         = var.admin_cidr
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "cluster_api_from_nodes" {
  security_group_id            = aws_security_group.cluster.id
  description                  = "Kubernetes API from the worker nodes"
  referenced_security_group_id = aws_security_group.nodes.id
  ip_protocol                  = "tcp"
  from_port                    = 443
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "nodes_from_nodes" {
  security_group_id            = aws_security_group.nodes.id
  description                  = "All traffic between the nodes (Pod to Pod)"
  referenced_security_group_id = aws_security_group.nodes.id
  ip_protocol                  = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "nodes_kubelet_from_cluster" {
  security_group_id            = aws_security_group.nodes.id
  description                  = "kubelet API from the control plane"
  referenced_security_group_id = aws_security_group.cluster.id
  ip_protocol                  = "tcp"
  from_port                    = 10250
  to_port                      = 10250
}

resource "aws_vpc_security_group_egress_rule" "cluster_all" {
  security_group_id = aws_security_group.cluster.id
  description       = "All outbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "nodes_all" {
  security_group_id = aws_security_group.nodes.id
  description       = "All outbound traffic (image pulls through the NAT gateway)"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
