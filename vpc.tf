provider "aws" {
  region = "ap-northeast-2"
}

locals {
  cluster_name = "hj-eks-test"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "hj-test"
  cidr = "10.49.0.0/16"

  azs             = ["ap-northeast-2a", "ap-northeast-2c"]
  public_subnets  = ["10.49.0.0/24", "10.49.0.0/24"]
  private_subnets = ["10.49.11.0/24", "10.49.111.0/24"]

  enable_nat_gateway     = true
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/external-elb"             = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}