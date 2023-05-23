output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_subnet_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "setup_kubeconfig_command" {
  value = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}

output "external_dns_role_arn" {
  value = module.external_dns_irsa.iam_role_arn
}

output "redis_endpoint" {
  value = module.redis.elasticache_replication_group_primary_endpoint_address
}