locals {
  common_tags = {
    Environment = var.environment
    managed_by  = "mokpolar"
    region      = var.region
  }

  acl_policy_allow_all = {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  vpc_name    = "${var.vpc_name}-vpc"
  private_subnets = var.private_subnets
}