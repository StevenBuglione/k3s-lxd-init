resource "kubernetes_manifest" "argocd_project_dev" {
  depends_on = [helm_release.argocd]

  manifest = yamldecode(data.http.project_dev_yaml.response_body)
}