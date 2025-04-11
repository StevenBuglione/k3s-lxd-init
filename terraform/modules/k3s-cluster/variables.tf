variable "k3s_version" {
  type    = string
  default = "latest"
}

variable "cluster_domain" {
  type    = string
  default = "cluster.local"
}

variable "cidr" {
  type = object({
    pods     = string
    services = string
  })
  default = {
    pods     = "10.42.0.0/16"
    services = "10.43.0.0/16"
  }
}

variable "global_flags" {
  type    = list(string)
  default = []
}

variable "k3s_install_env_vars" {
  type    = map(string)
  default = {}
}

variable "server_nodes" {
  type = list(object({
    name = string
    ip   = string
  }))
  description = "List of server nodes with name and IP"
}

variable "agent_nodes" {
  type = list(object({
    name = string
    ip   = string
  }))
  description = "List of agent nodes with name and IP"
  default = []
}


variable "connection" {
  type = object({
    user        = string
    private_key = string
    timeout     = string
  })
}

variable "server_flags" {
  type    = list(string)
  default = ["--disable=traefik","--write-kubeconfig-mode=644"]
}
