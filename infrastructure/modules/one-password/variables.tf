variable "vault_name" {
  type        = string
  description = "ID of the 1Password vault containing the item"
  nullable = false
}

variable "secret_name" {
  type = string
  description = "Name of the secret to request from one password connect server"
  nullable = true
  default = null
}

variable "secret_data" {
  type = object(
    {
      name = string
      fields = map(string)
    }
  )
  description = "Object to create a new secret in one password connect server"
  nullable = true
  default = null
}