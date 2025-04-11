resource "kubernetes_manifest" "argocd_root_app_dev" {
  depends_on = [kubernetes_manifest.argocd_project_dev]

  manifest = yamldecode(data.http.root_app_dev_yaml.response_body)
}