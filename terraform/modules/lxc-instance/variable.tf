variable "instance_name" {
  type        = string
  description = "Name of the LXC container instance."
}

variable "image" {
  type        = string
  default     = "ubuntu-daily:22.04"
  description = "Image to use for LXC container."
}

variable "lxd_host" {
  type        = string
  description = "Name of the LXD host where the container will be created."
}

variable "user_data" {
  type        = string
  description = "Cloud-init user data."
}

variable "network_config" {
  type        = string
  description = "Cloud-init network configuration."
}

variable "nic_type" {
  type        = string
  default     = "macvlan"
}

variable "nic_parent" {
  type        = string
  default     = "eth0"
}
