resource "kubernetes_namespace" "app1_env" {
  metadata {
    name = "app1-${var.env_type}"
  }
}