lxd_provider_config = {
  name = "klustered"
  address = "https://10.10.10.5:8443"
}

agent_nodes = [
  { name = "pluto", ip = "10.10.10.50/24" },
  { name = "neptune", ip = "10.10.10.51/24" },
  { name = "earth", ip = "10.10.10.53/24" },
]

server_nodes = [
  { name = "saturn", ip = "10.10.10.52/24" },
]

lxc_cloud_init_configuration = {
  user = {
    name = "ubuntu"
    shell = "/bin/bash"
    sudo = "ALL=(ALL) NOPASSWD:ALL"
    ssh_authorized_key = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGj8YZoLdswulAVs5PNq2FqWj7NluaCofmYCTk2I3+SO"
    ]
  }
  package_update = true
  package_upgrade = true
  packages = ["openssh-server"]
  runcmd = [
    "systemctl enable ssh",
    "systemctl restart ssh",
    "ufw allow 22/tcp",
    "ufw reload"
  ]
}

lxc_network_gateway4 = "10.10.10.1"
lxc_network_nameserver_addresses = ["10.10.10.1"]

argocd_admin_password = "password"
argo_project_dev_url = "https://raw.githubusercontent.com/StevenBuglione/k3s-argocd-boot/master/registry/projects/development/project-dev.yml"
argo_root_app_dev_url = "https://raw.githubusercontent.com/StevenBuglione/k3s-argocd-boot/master/registry/projects/development/root-app-dev.yml"
