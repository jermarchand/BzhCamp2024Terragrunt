output "all-ns" {
  value = data.kubernetes_all_namespaces.allns.namespaces
}

output "I_WORK_ON" {
  value = var.env_type
}