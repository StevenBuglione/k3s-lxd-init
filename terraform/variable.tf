variable "lxd_provider_config"{
  description = "Configuration required to configure the lxd provider remote configuration"
  type = object({
    name = string
    address = string
  })
}

variable "server_nodes" {
  type = list(object({
    name = string
    ip = string
  }))
  description = "List of server nodes with name and IP"
}

variable "agent_nodes" {
  type = list(object({
    name = string
    ip = string
  }))
  description = "List of agent nodes with name and IP"
  default = []
}

variable "lxc_cloud_init_configuration"{
  description = "Configuration used to configure lxc cloud init image"
  type = object({
    user = object({
      name = string
      shell = string
      sudo = string
      ssh_authorized_key = list(string)
    })
    package_update = bool
    package_upgrade = bool
    packages = list(string)
    runcmd = list(string)
  })
}

variable "lxc_network_gateway4"{
  description = "Configuration for lxc instance gateway4 ip address"
  type = string
}

variable "lxc_network_nameserver_addresses"{
  description = "Configuration for lxc nameserver ip addresses"
  type = list(string)
}