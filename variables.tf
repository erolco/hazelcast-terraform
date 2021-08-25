locals {
  cluster_name = "${(var.PROJECT_NAME)}-${(var.ENVIRONMENT_TYPE)}"
}

variable "aws_region" {
  description = "aws region"
  default     = "eu-central-1"
}

variable "environment_type" {
  description = "type of the environment"
  default     = "dev"
}

variable "project_name" {
  description = "name of the project"
}

variable "vpc_cdr_block" {
  description = "Provide aws cidr block for whole vpc"
  default     = "10.1.0.0/24"
}

variable "public_subnets" {
  default     = []
  description = "list of public cidr bloks per availability zones"
  type        = list(string)
}

variable "private_subnets" {
  default     = []
  description = "cidr bloks per availability zones"
  type        = list(string)
}

variable "cluster_version" {
  default     = "1.14"
  description = "EKS cluster version"
}

variable "instance_type" {
  default     = "t3.medium"
  description = "node instance type"
}

variable "node_size" {
  default     = "3"
  description = "EKS node group size"
}

variable "kubeconfig_path" {
  default     = null
  description = "kubeconfig path"
}

variable "monitoring_auth" {
  description = "Provide basic auth generated with `htpasswd auth <user>` for monitoring tools"
}