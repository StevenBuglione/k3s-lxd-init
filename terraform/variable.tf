variable "lxd_provider_config"{
  description = "Configuration required to configure the lxd provider remote configuration"
  type = object({
    name = string
    address = string
    client_cert = string
    client_key = string
    accept_remote_certificate = bool
  })
}