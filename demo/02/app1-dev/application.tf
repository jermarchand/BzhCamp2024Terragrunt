
resource "kubernetes_deployment" "app1_dev" {
  metadata {
    name      = "app1-dev"
    namespace = kubernetes_namespace.app1_dev.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "MyTestApp"
      }
    }
    template {
      metadata {
        labels = {
          app      = "MyTestApp"
          password = var.env_type
        }
      }
      spec {
        container {
          image_pull_policy = "IfNotPresent"
          image             = "traefik/whoami"
          name              = "whoami-container"
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
    name      = "app1-dev"
    namespace = kubernetes_namespace.app1_dev.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.app1_dev.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = 30201
      port        = 80
      target_port = 80
    }
  }
}