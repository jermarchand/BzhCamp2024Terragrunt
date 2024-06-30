resource "random_string" "random" {
  count   = var.env_type == "dev" ? 1 : 0
  length  = 10
  special = false
  lower   = true
  numeric = false
  upper   = true
}
