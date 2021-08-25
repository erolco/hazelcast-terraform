module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "${local.cluster_name}-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.security_group_alb.this_security_group_id]

  target_groups = [
    {
      name_prefix          = "main"
      backend_protocol     = "HTTP"
      backend_port         = 1080
      target_type          = "instance"
      deregistration_delay = 60
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/healthz"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Name        = "${local.cluster_name}-alb"
    Terraform   = "true"
    Environment = var.environment_type
    Project     = var.project_name
  }
}
