provider "aws" {
  region = local.region
}

# Terraform workspace : S3 bucket에 tfstate를 저장
terraform {
  backend "s3" {
    region = "us-west-2" # S3 bucket region
    bucket = "mokpolar-terraform-backend-bucket" # S3 bucket 생성 후 해당 이름 입력
    key    = "my-eks-cluster/eks.tfstate" # 하부 경로명
  }
}

# EKS 생성에 필요한 VPC 정보는 VPC 생성 후 저장된 아래 Terraform workspace에서 읽어들임
data "terraform_remote_state" "vpc" {
  backend  = "s3"
  config = {
    region = "us-west-2"
    bucket = "mokpolar-terraform-backend-bucket"
    key    = "my-eks-cluster/vpc.tfstate"
  }
}

module "eks" {
  source                                   = "../../modules/eks"
  region                                   = local.region
  environment                              = local.environment
  cluster_name                             = local.cluster_name
  cluster_version                          = local.cluster_version
  cluster_endpoint_public_access_nat_cidrs = data.terraform_remote_state.vpc.outputs.nat_public_ips
  eks_managed_node_groups                  = local.eks_managed_node_groups
  eks_vpc_id                               = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr_block                           = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
  eks_subnet_ids                           = data.terraform_remote_state.vpc.outputs.private_subnets
  aws_auth_users_list                      = local.aws_auth_users_list
}