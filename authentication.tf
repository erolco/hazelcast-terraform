resource "kubernetes_secret" "monitoring_auth" {
  metadata {
    name      = "monitoring-auth"
    namespace = "monitoring"
  }

  data = {
    auth = var.monitoring_auth
  }

  depends_on = [helm_release.prometheus_operator]
}