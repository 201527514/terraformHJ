variable "region" {
  type        = string
  description = "AWS region"
}

variable "environment" {
  type        = string
  description = "Environment name like dev, prod"
}

variable "cluster_name" {
  type        = string
  description = "My EKS name"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version"
}

variable "cluster_endpoint_public_access_nat_cidrs" {
  type        = list(string)
  description = "VPC NAT cidrs must be included in cluster_endpoint_public_access_cidrs"
}

variable "eks_vpc_id" {
  type        = string
  description = "EKS VPC ID"
}

variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block"
}

variable "eks_subnet_ids" {
  type        = list(string)
  description = "AWS EKS Subnet IDs"
}

variable "eks_managed_node_groups" {
  type = list(object({
    node_type = string
    count     = number

    capacity_type  = string
    instance_types = list(string)

    disk_size = number

    taint = bool
  }))
  
  default = [
    {
      node_type      = "default"
      count          = 1
      capacity_type  = "ON_DEMAND"
      instance_types = ["m5.xlarge"]
      max_size       = 10
      disk_size      = 10
      taint          = false
    }
  ]
}

variable "eks_managed_node_group_disk_type" {
  type        = string
  description = "eks managed node group disk type: either gp3 or gp2"
  default     = "gp2"
}

variable "aws_auth_users_list" {
  type = any
  description = "Map of aws auth users"
  default = []
}