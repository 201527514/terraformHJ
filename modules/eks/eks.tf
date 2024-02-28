data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_id     = var.eks_vpc_id
  subnet_ids = var.eks_subnet_ids

  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_nat_cidrs

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    version  = var.cluster_version

    disk_size = 10
    disk_type = var.eks_managed_node_group_disk_type

    vpc_security_group_ids = aws_security_group.nginx-ingress-access.id
  }
  tags = local.common_tags
}