# variables.tf
variable "argocd_admin_password" {
  description = "Argo CD admin user password (plaintext input, will be stored as bcrypt hash in cluster)"
  type        = string
  sensitive   = true
}

variable "argo_project_dev_url"{
  description = "The raw git url to the argocd project file"
  type = string
}

variable "argo_root_app_dev_url"{
  description = "The raw git url to the argocd root app file"
  type = string
}
