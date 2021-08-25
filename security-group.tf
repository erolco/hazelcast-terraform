module "security_group_alb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name   = "${local.cluster_name}-alb"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    Name        = "${local.cluster_name}-alb"
    Terraform   = "true"
    Environment = var.environment_type
    Project     = var.project_name
  }
}

module "security_group_alb_to_worker_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name   = "${local.cluster_name}-alb-to-worker-group"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 1080
      to_port     = 1080
      protocol    = "tcp"
      cidr_blocks = var.VPC_CIDR_BLOCK
    },
  ]

  egress_rules        = ["all-all"]

  tags = {
    Name        = "${local.cluster_name}-alb-to-worker-group"
    Terraform   = "true"
    Environment = var.environment_type
    Project     = var.project_name
  }
}