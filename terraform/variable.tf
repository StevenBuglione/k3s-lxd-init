variable "lxd_provider_config"{
  description = "Configuration required to configure the lxd provider remote configuration"
  type = object({
    name = string
    address = string
  })
}