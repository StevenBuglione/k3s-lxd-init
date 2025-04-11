locals {
  ks3_server_nodes = [
    for node in var.server_nodes : {
      name = node.name
      ip = module.lxc_nodes[node.name].instance_ip
    }
  ]

  ks3_agent_nodes = [
    for node in var.agent_nodes : {
      name = node.name
      ip = module.lxc_nodes[node.name].instance_ip
    }
  ]
  k3s_connection = {
    user        = var.lxc_cloud_init_configuration.user.name
    private_key = file("~/.ssh/ansible-key")
    timeout     = "120s"
  }

  k3s_global_flags = [
    "--flannel-iface eth0",
    "--kubelet-arg=protect-kernel-defaults=false",
    "--kubelet-arg=fail-swap-on=false"
  ]

  k3s_install_env_vars = {
    INSTALL_K3S_SKIP_SELINUX_RPM = "true"
  }
}