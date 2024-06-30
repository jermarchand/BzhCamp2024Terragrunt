resource "kubernetes_namespace" "app1_int" {
  metadata {
    name = "app1-int"
  }
}