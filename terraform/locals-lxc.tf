locals {
  lxc_cloud_init_base = {
    users = [{
      name                = var.lxc_cloud_init_configuration.user.name
      shell               = "/bin/bash"
      sudo                = "ALL=(ALL) NOPASSWD:ALL"
      ssh-authorized-keys = var.lxc_cloud_init_configuration.user.ssh_authorized_key
    }]
    package_update  = var.lxc_cloud_init_configuration.package_update
    package_upgrade = var.lxc_cloud_init_configuration.package_upgrade
    packages        = var.lxc_cloud_init_configuration.packages
    runcmd          = var.lxc_cloud_init_configuration.runcmd
  }

  # Create properly formatted cloud-init config with header
  lxc_cloud_init = "#cloud-config\n${yamlencode(local.lxc_cloud_init_base)}"

  hosts = { for host in concat(var.server_nodes, var.agent_nodes) : host.name => host }

}