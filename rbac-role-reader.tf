resource "kubernetes_role" "reader" {
  metadata {
    name = "eks-reader"
    namespace = "default"
    labels = {
      role = "reader"
    }
  }

  rule {
    api_groups     = [""]
    resources      = ["pods"]
    resource_names = ["foo"]
    verbs          = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments"]
    verbs      = ["get", "list"]
  }
}