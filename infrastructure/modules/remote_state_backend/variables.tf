# Name of the bucket to store Terraform state (can be customized)
variable "state_bucket_name" {
  description = "Name of the MinIO bucket for Terraform state"
  default     = "terraform-state"
}

variable "state_bucket_retention_days" {
  description = "Number of day to configure the default object lock retention"
  type = number
  default = null
}

variable "minio_server" {
  description = "MinIO server endpoint (host:port or URL)"
  type = string
}

variable "minio_region" {
  description = "MinIO region (use default us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "vault_name" {
  type        = string
  description = "Name of the 1Password vault containing the item"
  default = null
}