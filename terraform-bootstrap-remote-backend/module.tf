resource "minio_s3_bucket" "state_terraform_s3" {
  bucket = "state-terraform-s4"
  acl    = "public"
}