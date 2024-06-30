
resource "kubernetes_deployment" "app1_int" {
  metadata {
    name      = "app1-int"
    namespace = kubernetes_namespace.app1_int.metadata[0].name
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

resource "kubernetes_service" "app1_int" {
  metadata {
    name      = "app1-int"
    namespace = kubernetes_namespace.app1_int.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment.app1_int.spec[0].template[0].metadata[0].labels.app
    }
    type = "NodePort"
    port {
      node_port   = var.service_port
      port        = 80
      target_port = 80
    }
  }
}