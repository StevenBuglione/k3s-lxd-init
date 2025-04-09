terraform {
  required_providers {
    onepassword = {
      source  = "1password/onepassword"
      version = ">= 2.1.2"
    }
  }
}

variable "vault_id" {
  type        = string
  description = "ID of the 1Password vault containing the item"
}
variable "item_title" {
  type        = string
  description = "Title of the 1Password item with MinIO credentials"
}

provider "onepassword" {
  # Using 1Password Connect – credentials are sourced from environment:
  # OP_CONNECT_HOST (URL of Connect server) and OP_CONNECT_TOKEN (API token)
  # This keeps secrets out of code&#8203;:contentReference[oaicite:3]{index=3}.
}


data "onepassword_item" "minio_state" {
  vault = var.vault_id
  title = var.item_title
  # The item is expected to be of category "login" with username, password, URL.
}

output "minio_user" {
  value     = data.onepassword_item.minio_state.username
  sensitive = true
}
output "minio_password" {
  value     = data.onepassword_item.minio_state.password
  sensitive = true
}

output "minio_server" {
  value = data.onepassword_item.minio_state.section[0].field[0].value
  sensitive = true
}
