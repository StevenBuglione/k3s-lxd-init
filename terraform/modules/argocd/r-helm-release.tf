resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.27.1"
  namespace        = "argocd"
  create_namespace = true

  wait    = true
  timeout = 600  # Wait up to 10 minutes for CRDs
}