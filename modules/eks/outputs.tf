output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "cluster_id" {
  description = "Kubernetes Cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_oidc_issuer_url" {
  description = "EKS Cluster OIDC Issuer URL"
  value       = module.eks.cluster_oidc_issuer_url
}

output "cluster_primary_security_group_id" {
  description = "The cluster primary security group ID created by the EKS cluster on 1.14 or later. Referred to as 'Cluster security group' in the EKS console."
  value       = module.eks.cluster_primary_security_group_id
}

output "oidc_provider_arn" {
  description = "EKS Cluster OIDC Provider ARN"
  value       = module.eks.oidc_provider_arn
}

output "oidc_provider" {
  description = "EKS Cluster OIDC Provider"
  value       = module.eks.oidc_provider
}