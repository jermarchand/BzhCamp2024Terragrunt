resource "kubernetes_namespace" "app1_dev" {
  metadata {
    name = "app1-dev"
  }
}