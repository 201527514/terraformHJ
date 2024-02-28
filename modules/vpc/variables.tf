variable "region" {
  type        = string
  description = "AWS region"
}

variable "environment" {
  type        = string
  description = "Environment name like dev, prod"
}

variable "vpc_name" {
  type        = string
  description = "AWS VPC name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block of the VPC"
}

variable "azs" {
  type        = list(string)
  description = "A list of availability zones names or ids in the region"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of IDs of private subnets"
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  description = "List of IDs of public subnets"
  default     = []
}

variable "enable_dns_hostnames" {
  default     = true
  type        = bool
  description = "Should be true to enable DNS hostnames in the VPC"
}

variable "enable_dns_support" {
  default     = true
  type        = bool
  description = "Should be true to enable DNS support in the VPC"
}

variable "enable_nat_gateway" {
  default     = true
  type        = bool
  description = "Should be true if you want to provision NAT Gateways for each of your private networks	"
}

variable "single_nat_gateway" {
  default     = false
  type        = bool
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks	"
}

variable "one_nat_gateway_per_az" {
  default     = true
  type        = bool
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires var.azs to be set, and the number of public_subnets created to be greater than or equal to the number of availability zones specified in var.azs.	"
}

variable "enable_flow_log" {
  default     = true
  type        = bool
  description = "whether or not to enable vpc flow logs"
}