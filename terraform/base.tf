resource "lxd_instance" "ssh_box" {
  count  = 8
  name   = "dev-ssh-box-${count.index}"
  image  = "ubuntu-daily:22.04"

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
  }

  device {
    name       = "eth0"
    type       = "nic"
    properties = {
      nictype = "macvlan"
      parent  = "eth0"  // Replace with your actual physical interface if different.
    }
  }
}



