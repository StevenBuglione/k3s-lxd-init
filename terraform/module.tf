module "lxc_nodes" {
  source   = "./modules/lxc-instance"
  for_each = { for host in local.hosts : host.name => host }

  instance_name = "${each.value.name}-dev"
  lxd_host      = each.value.name
  user_data     = local.lxc_cloud_init
  network_config = yamlencode({
    version = 2
    ethernets = {
      eth0 = {
        dhcp4     = false
        addresses = [each.value.ip]
        gateway4  = var.lxc_network_gateway4
        nameservers = {
          addresses = var.lxc_network_nameserver_addresses
        }
      }
    }
  })
}

module "k3s_cluster" {
  source = "./modules/k3s-cluster"

  server_nodes = local.ks3_server_nodes
  agent_nodes = local.ks3_agent_nodes
  connection = local.k3s_connection
  global_flags = local.k3s_global_flags
  k3s_install_env_vars = local.k3s_install_env_vars

  depends_on = [module.lxc_nodes]
}