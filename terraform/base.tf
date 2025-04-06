resource "lxd_instance" "ssh_box" {
  count  = 4
  name   = "dev-ssh-box-${count.index}"
  image  = "ubuntu-daily:22.04"
  target = element(["pluto", "neptune", "saturn", "earth"], count.index)

  config = {
    "user.user-data" = <<EOF
#cloud-config
users:
  - name: ubuntu
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIADXEW0ESKUfvgzAYIuHH/Rehcvhm8j4op7VlpLClfvC

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
      addresses: [1.1.1.1, 8.8.8.8]
EOF
  }

  limits = {
    cpu    = "2"
    memory = "2GB"
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      nictype = "macvlan"
      parent  = "eth0"
    }
  }
}
