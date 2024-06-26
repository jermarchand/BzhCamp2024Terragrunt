########################################################
# Provider 
provider "kubernetes" {
  config_path = "~/.kube/config"
}

########################################################
# Resources 
resource "kubernetes_namespace" "app1_dev" {
  metadata {
    name = "app1-dev"
  }
}

resource "kubernetes_deployment" "app1_dev" {
  metadata {
    name = "app1-dev"
    namespace = kubernetes_namespace.app1_dev.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "MyTestApp"
      }
    }
    template {
      metadata {
        labels = {
          app = "MyTestApp"
          password = var.env_type
        }
      }
      spec {
        container {
          image_pull_policy = "IfNotPresent"
          image = "traefik/whoami"
          name  = "whoami-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app1_dev" {
  metadata {
    name = "app1-dev"
    namespace = kubernetes_namespace.app1_dev.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.app1_dev.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port = 30201
      port = 80
      target_port = 80
    }
  }
}

resource "random_string" "random" {
  count = var.env_type == "dev" ? 1 : 0
  length  = 10
  special = false
  lower = true
  numeric = false
  upper = true
}

variable "env_type" {
  description = "Type d'environement"
  type = string
  default   = "dev"

  validation {
    condition   = contains(["dev", "ppr", "prd"], var.env_type)
    error_message = "Mauvaise valeur"
  }
}

data "kubernetes_all_namespaces" "allns" {}

output "all-ns" {
  value = data.kubernetes_all_namespaces.allns.namespaces
}


terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }

  backend "s3" {
    bucket = "tf-backends"
    key  = "app1-dev-terraform.tfstate"

    endpoints = {
      s3 = "http://minio-ui.test"
    }

    access_key = "FLVqceSq1cv7YgOS"
    secret_key = "tGb5kZGn7B3VcKfyGnaLiqbtPjlwFXPm"

    region               = "main"
    skip_credentials_validation = true
    skip_metadata_api_check   = true
    skip_region_validation = true
    skip_requesting_account_id  = true
    force_path_style     = true
  }
}
