resource "lxd_instance" "main" {
  name   = var.instance_name
  image  = var.image
  target = var.lxd_host

  config = {
    "security.nesting"       = "true"
    "security.privileged"    = "true"
    "linux.kernel_modules"   = "overlay,nf_nat,ip_tables,ip6_tables"
    "raw.lxc"                = "lxc.apparmor.profile=unconfined\nlxc.cap.drop=\nlxc.cgroup.devices.allow=a\nlxc.mount.auto=proc:rw sys:rw"
    "user.user-data"         = var.user_data
    "user.network-config"    = var.network_config
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      nictype = var.nic_type
      parent  = var.nic_parent
    }
  }

  device {
    name = "kmsg"
    type = "unix-char"
    properties = {
      source = "/dev/null"
      path   = "/dev/kmsg"
    }
  }
}