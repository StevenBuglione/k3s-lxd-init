resource "local_file" "kube_config" {
  depends_on = [module.k3s_cluster]
  content    = module.k3s_cluster.kube_config_local
  filename   = pathexpand("~/.kube/config")
  file_permission = "0600"
}