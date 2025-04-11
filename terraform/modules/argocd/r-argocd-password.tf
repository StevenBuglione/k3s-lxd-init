# resource "kubernetes_manifest" "argocd_admin_password" {
#   depends_on = [helm_release.argocd]
#
#   manifest = {
#     apiVersion = "v1"
#     kind       = "Secret"
#     metadata = {
#       name      = "argocd-secret"
#       namespace = "argocd"
#     }
#
#     stringData = {
#       "admin.password"      = bcrypt(var.argocd_admin_password)
#       "admin.passwordMtime" = timestamp()
#     }
#   }
# }
