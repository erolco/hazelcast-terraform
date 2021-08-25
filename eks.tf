module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "7.0.1"

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version
  kubeconfig_name = "kubeconfig"

  subnets = module.vpc.private_subnets
  vpc_id  = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "${local.cluster_name}-worker-group"
      instance_type                 = var.instance_type
      asg_desired_capacity          = var.node_size
      additional_security_group_ids = [module.security_group_alb_to_worker_group.this_security_group_id]
      target_group_arns             = module.alb.target_group_arns
    }
  ]

  tags = {
    Name        = "${local.cluster_name}-eks"
    Terraform   = "true"
    Environment = var.environment_type
    Project     = var.project_name
  }
}