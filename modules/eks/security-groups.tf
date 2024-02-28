resource "aws_security_group" "nginx-ingress-access" {
  name        = "${var.cluster_name}-nginx-ingress-access"
  description = "${var.cluster_name} nginx-ingress inbound and outbound security group"
  vpc_id      = var.eks_vpc_id

  tags = {
    Name = "${var.cluster_name}-nginx-ingress-access-sg"
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = 6
    cidr_blocks = concat(
      local.default_cluster_endpoint_public_access_cidrs,
      var.cluster_endpoint_public_access_nat_cidrs,
    )
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = 6
    cidr_blocks = concat(
      local.default_cluster_endpoint_public_access_cidrs,
      var.cluster_endpoint_public_access_nat_cidrs,
    )
  }
}