module "redis" {
  source  = "umotif-public/elasticache-redis/aws//examples/redis-basic"
  version = "3.3.0"

  name_prefix        = "podinfo-redis-"
  num_cache_clusters = 2
  node_type          = "cache.t4g.small"

  engine_version            = "6.x"
  port                      = 6379
  maintenance_window        = "mon:03:00-mon:04:00"
  snapshot_window           = "04:00-06:00"
  snapshot_retention_limit  = 7
  final_snapshot_identifier = "redis-final-snapshot-name"

  automatic_failover_enabled = true
  multi_az_enabled           = true

  apply_immediately = true
  family            = "redis6.x"

  subnet_ids = module.vpc.elasticache_subnets
  vpc_id     = module.vpc.vpc_id

  allowed_security_groups = [module.eks.node_security_group_id]
}