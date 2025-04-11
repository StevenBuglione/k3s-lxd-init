# Create MinIO bucket for Terraform state, with object locking enabled
resource "minio_s3_bucket" "state" {
  bucket         = var.state_bucket_name
  acl            = "private"
  object_locking = false
}

resource "minio_s3_bucket_versioning" "state" {
  bucket = minio_s3_bucket.state.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

# resource "minio_s3_bucket_retention" "state" {
#   count = var.state_bucket_retention_days != null ? 1 : 0
#   bucket   = minio_s3_bucket.state.bucket
#   mode     = "GOVERNANCE"
#   unit     = "DAYS"
#   validity_period = var.state_bucket_retention_days
# }