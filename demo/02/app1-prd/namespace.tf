resource "kubernetes_namespace" "app1_prd" {
  metadata {
    name = "app1-prd"
  }
}