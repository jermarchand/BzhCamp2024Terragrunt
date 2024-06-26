variable "env_type" {
  description = "Type d'environement"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "int", "prd"], var.env_type)
    error_message = "Mauvaise valeur"
  }
}

variable "service_port" {
  description = "Service port"
  type        = number
  default     = 30201
}

variable "nb_replicats" {
  description = "Nombre de réplicats"
  type        = number
  default     = 1
}