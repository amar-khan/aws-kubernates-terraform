resource "kubernetes_ingress" "example_ingress" {
  metadata {
    name = "example-ingress"
  }

  spec {
    backend {
      service_name = "appone"
      service_port = 8080
    }

    rule {
      http {
        path {
          backend {
            service_name = "appone"
            service_port = 8080
          }

          path = "/app1/*"
        }

        path {
          backend {
            service_name = "apptwo"
            service_port = 8080
          }

          path = "/app2/*"
        }
      }
    }

    tls {
      secret_name = "tls-secret"
    }
  }
}

resource "kubernetes_pod" "example" {
  metadata {
    name = "terraform-example"
    labels = {
      app = "appone"
    }
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "example"

      port {
        container_port = 8080
      }
    }
  }
}

resource "kubernetes_pod" "example2" {
  metadata {
    name = "terraform-example2"
    labels = {
      app = "apptwo"
    }
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "example"

      port {
        container_port = 8080
      }
    }
  }
}