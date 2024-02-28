locals { 
  region          = "us-west-2" # AWS region 선택
  vpc_name        = "my-vpc" # VPC 이름
  
  environment     = "prod" # tag에 집어넣을 환경명
  
  vpc_cidr_block  = "10.0.0.0/16" # VPC CIDR block
  azs             = ["us-west-2a", "us-west-2b"] # AWS Avaiability Zones
  private_subnets = ["10.0.128.0/20", "10.0.144.0/20"] # Private Subnets CIDR
  public_subnets  = ["10.0.0.0/20", "10.0.16.0/20",] # Public Subnets CIDR
}