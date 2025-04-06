module "k3s" {
  source       = "../k3s"
  k3s_version  = var.k3s_version
  cluster_domain = var.cluster_domain
  cidr         = var.cidr
  global_flags = var.global_flags

  k3s_install_env_vars = var.k3s_install_env_vars
  managed_fields = ["label", "taint"]

  servers = {
    for idx, node in var.server_nodes :
    "${node.name}-server-${idx + 1}" => {
      ip         = node.ip
      connection = var.connection
      flags      = var.server_flags
    }
  }

  agents = {
    for idx, node in var.agent_nodes :
    "${node.name}-worker-${idx + 1}" => {
      ip         = node.ip
      connection = var.connection

    }
  }
}
