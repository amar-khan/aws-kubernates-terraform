resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx-deployment"
    labels = {
      App = "nginx"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        App = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          App = "nginx"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "nginx"

          port {
            name           = "health"
            container_port = 80
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
           readiness_probe {
            http_get {
              path   = "/"
              port   = "health"
              scheme = "HTTP"
            }

            initial_delay_seconds = 30
            period_seconds        = 60
            timeout_seconds       = 3
          }
          liveness_probe {
            http_get {
              path   = "/"
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
