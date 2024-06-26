variable "env_type" {
  description = "Type d'environement"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "ppr", "prd"], var.env_type)
    error_message = "Mauvaise valeur"
  }
}

# variable "service_port" {
#   description = "Service port"
#   type        = number
#   default     = 30201
# }