output "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = minio_s3_bucket.state.bucket
}

output "minio_endpoint" {
  description = "MinIO endpoint URL for S3 API"
  value       = var.minio_server
}

output "minio_region" {
  description = "Region for the MinIO bucket (use in backend configuration)"
  value       = var.minio_region
}

output "state_access_key" {
  description = "Access key (username) for CI/CD user with RW access"
  value       = minio_iam_user.cicd_user.name
}

output "state_secret_key" {
  description = "Secret key for CI/CD user with RW access"
  value       = minio_iam_user.cicd_user.secret
  sensitive   = true
}
