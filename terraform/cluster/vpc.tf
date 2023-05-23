module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "vpc-${local.env_name}"
  cidr = local.vpc_cidr

  azs                 = [data.aws_availability_zones.azs.names[0], data.aws_availability_zones.azs.names[1], data.aws_availability_zones.azs.names[2]]
  private_subnets     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets    = ["10.0.151.0/24", "10.0.152.0/24", "10.0.153.0/24"]
  elasticache_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]

  # Nat gateways
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true


  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  vpc_flow_log_tags = {
    Name = "vpc-${local.env_name}"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
}