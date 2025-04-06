output "instance_name" {
  value = lxd_instance.main.name
}

output "instance_ip" {
  value = lxd_instance.main.interfaces.eth0.ips[0].address
}
