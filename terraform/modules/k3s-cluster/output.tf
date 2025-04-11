output "kube_config_local" {
  value     = module.k3s.kube_config
  sensitive = true
}
