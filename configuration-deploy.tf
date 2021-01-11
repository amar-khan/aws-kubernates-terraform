resource "kubernetes_deployment" "configuration" {
  metadata {
    name = "configuration-deployment"
    labels = {
      App = "configuration"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        App = "configuration"
      }
    }
    template {
      metadata {
        labels = {
          App = "configuration"
        }
      }
      spec {
        container {
          image = "xxxxxxxxxxxx.dkr.ecr.us-east-2.amazonaws.com/poc:configuration-service"
          name  = "configuration"

          port {
            name           = "health"
            container_port = 8888
            protocol       = "TCP"
          }


          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          env {
            name = "spring.cloud.config.server.git.password"
            value = "xxxxxxxxxxxxxxxxxxxxxx"
          }
          env {
            name = "spring.cloud.config.server.git.username"
            value = "amarkotasky"
          }          
           readiness_probe {
            http_get {
              path   = "/actuator/health"
              port   = "health"
              scheme = "HTTP"
            }

            initial_delay_seconds = 30
            period_seconds        = 60
            timeout_seconds       = 3
          }
          liveness_probe {
            http_get {
              path   = "/actuator/health"
              port   = "health"
              scheme = "HTTP"
            }

            initial_delay_seconds = 60
            period_seconds        = 60
          }
        }
      }
    }
  }
}
