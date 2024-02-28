data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name                  = "${var.vpc_name}-vpc"
  cidr                  = var.vpc_cidr_block

  azs              = var.azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets

  manage_default_route_table = true
  default_route_table_tags   = { default_route_table = true }

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
  reuse_nat_ips          = false

  default_security_group_name    = "${var.vpc_name}-vpc-sg-default"
  default_security_group_ingress = []
  default_security_group_egress  = []
  manage_default_security_group  = true

  default_network_acl_name    = "${var.vpc_name}-vpc-acl-default"
  default_network_acl_ingress = [local.acl_policy_allow_all]
  default_network_acl_egress  = [local.acl_policy_allow_all]
  manage_default_network_acl  = true

  enable_flow_log                      = var.enable_flow_log
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 600
  vpc_flow_log_tags                    = merge(local.common_tags, { "vpc" = "${var.vpc_name}-vpc" })

  tags = local.common_tags
  
  public_subnet_tags= {
    "subnet_class"                          = "public"
    "kubernetes.io/cluster/${var.vpc_name}" = "shared"
    "kubernetes.io/role/elb"                = 1
  }

  private_subnet_tags = {
      "subnet_class"                    = "private"
      "kubernetes.io/role/internal-elb" = 1
    }
}