locals {
  region          = "us-west-2"  # AWS region 선택 : VPC와 동일하게
  cluster_name    = "my-eks-cluster" # EKS 이름 작성
  cluster_version = "1.23" # Kubernetes version

  environment     = "prod" # tag에 집어넣을 환경명

  # AWS EKS Managed node group 으로 node 생성
  eks_managed_node_groups = [
    {
      ami_type = "AL2_x86_64"
      node_type      = "default"
      count          = 1
      capacity_type  = "ON_DEMAND"
      instance_types = ["m5.xlarge"]
      disk_size      = 10
      taint          = false
    }
  ]
  
  # 권한 유저
  aws_auth_users_list = [
    {
      userarn  = "arn:aws:iam::my-account:user/my-user@example.com"
      username = "my-user@example.com"
      groups   = ["system:masters"]
    }
  ]
}