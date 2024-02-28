provider "aws" {
  region = local.region
}

# Terraform workspace : S3 bucket에 tfstate를 저장
terraform {
  backend "s3" {
    region = "us-west-2" # S3 bucket region
    bucket = "mokpolar-terraform-backend-bucket" # S3 bucket 생성 후 해당 이름 입력
    key    = "my-eks-cluster/vpc.tfstate" # 하부 경로명
  }
}

module "vpc" {
  source          = "../../modules/vpc"
  region          = local.region
  environment     = local.environment
  vpc_name        = local.vpc_name
  vpc_cidr_block  = local.vpc_cidr_block
  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
}