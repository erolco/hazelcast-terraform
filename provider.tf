terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  version = "~> 2.43"
  region  = var.AWS_REGION
}

provider "local" {
  version = "~> 1.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}

provider "kubernetes" {
  version     = "~> 1.10"
  config_path = var.kubeconfig_path != null ? var.kubeconfig_path : module.eks.kubeconfig_filename
}

provider "helm" {
  version         = "~> 0.10"
  max_history     = 10
  service_account = kubernetes_service_account.tiller.metadata[0].name
  namespace       = kubernetes_service_account.tiller.metadata[0].namespace
  override        = ["'spec.template.spec.containers[0].command'='{/bin/tiller,--storage=secret,--listen=localhost:44134}'"]

  kubernetes {
    config_path = var.kubeconfig_path != null ? var.kubeconfig_path : module.eks.kubeconfig_filename
  }
}