variable "minio_endpoint" {
  type        = string
  description = "Minio server endpoint"
}

variable "minio_user" {
  type        = string
  description = "Minio access key"
}

variable "minio_password" {
  type        = string
  description = "Minio secret key"
  sensitive   = true
}