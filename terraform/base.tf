resource "lxd_instance" "ssh_box" {
  count  = 4
  name   = "dev-ssh-box-${count.index}"
  image  = "ubuntu-daily:22.04"
  target = element(["pluto", "neptune", "saturn", "earth"], count.index)

  config = {
    "security.nesting" = "true"
    "security.privileged" = "true"
    "linux.kernel_modules" = "overlay,nf_nat,ip_tables,ip6_tables"
    "raw.lxc" = "lxc.apparmor.profile=unconfined\nlxc.cap.drop= \nlxc.cgroup.devices.allow=a\nlxc.mount.auto=proc:rw sys:rw"
    "user.user-data" = <<EOF
#cloud-config
users:
  - name: ubuntu
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGj8YZoLdswulAVs5PNq2FqWj7NluaCofmYCTk2I3+SO

package_update: true
package_upgrade: true
packages:
  - openssh-server

runcmd:
  - systemctl enable ssh
  - systemctl restart ssh
  - ufw allow 22/tcp
  - ufw reload
EOF

    "user.network-config" = <<EOF
version: 2
ethernets:
  eth0:
    dhcp4: false
    addresses:
      - ${element(["10.10.10.50/24", "10.10.10.51/24", "10.10.10.52/24", "10.10.10.53/24"], count.index)}
    gateway4: 10.10.10.1
    nameservers:
      addresses: [10.10.10.1]
EOF
  }

  limits = {
    cpu    = "4"
    memory = "8GB"
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      nictype = "macvlan"
      parent  = "eth0"
    }
  }


  device {
    name = "kmsg"
    type = "unix-char"
    properties = {
      source = "/dev/null"  # Redirect to /dev/null as a workaround
      path = "/dev/kmsg"
    }
  }
}

# Extract IPs from the CIDR notation in your network config
locals {
  node_ips = [for idx in range(4) : split("/", element(["10.10.10.50/24", "10.10.10.51/24", "10.10.10.52/24", "10.10.10.53/24"], idx))[0]]
}

module "k3s" {
  source  = "xunleii/k3s/module"
  depends_on = [lxd_instance.ssh_box]
  k3s_version    = "latest"
  cluster_domain = "cluster.local"
  cidr = {
    pods     = "10.42.0.0/16"
    services = "10.43.0.0/16"
  }
  drain_timeout  = "30s"
  managed_fields = ["label", "taint"] // ignore annotations

  global_flags = [
    "--flannel-iface eth0",
    "--kubelet-arg=protect-kernel-defaults=false", # Skip kernel parameter checks
    "--kubelet-arg=fail-swap-on=false"             # Don't require swap to be off
  ]

  # Add this line to fix the error
  k3s_install_env_vars = {
    INSTALL_K3S_SKIP_SELINUX_RPM = "true"
  }

  # Configure first node as server
  servers = {
    master = {
      ip = local.node_ips[0]
      connection = {
        user        = "ubuntu"
        private_key = file("/home/sbuglione/.ssh/ansible-key")
        timeout     = "60s"
      }
      flags = ["--disable=traefik"]
    }
  }

  # Configure remaining nodes as agents
  agents = {
    for idx in range(1, length(local.node_ips)) :
    "worker-${idx}" => {
      ip = local.node_ips[idx]
      connection = {
        user        = "ubuntu"
        private_key = file("/home/sbuglione/.ssh/ansible-key")
        timeout     = "60s"
      }
    }
  }
}

# Output the kubeconfig for cluster access
output "k3s_kubeconfig" {
  value     = module.k3s.kube_config
  sensitive = true
  description = "Kubeconfig for accessing the k3s cluster"
}

resource "local_file" "kubeconfig" {
  depends_on = [module.k3s]
  content    = module.k3s.kube_config
  filename   = pathexpand("~/.kube/config")
  file_permission = "0600"
}

output "kubeconfig_path" {
  value       = local_file.kubeconfig.filename
  description = "Path to the saved kubeconfig file"
}
