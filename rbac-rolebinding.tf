resource "kubernetes_role_binding" "rolebindings" {
  metadata {
    name      = "terraform-rolebindings"
    namespace = "default"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "eks-reader"
  }
  subject {
    kind      = "User"
    name      = "amar.khan-other"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "kube-system"
  }
  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }
}