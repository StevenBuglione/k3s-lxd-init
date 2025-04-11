# Create IAM users (access key pairs) for each role
resource "minio_iam_user" "admin_user" {
  name          = "terraform-state-admin-user"
  force_destroy = true
}
resource "minio_iam_user" "cicd_user" {
  name          = "terraform-state-ci-cd-user"
  force_destroy = true
}
resource "minio_iam_user" "readonly_user" {
  name          = "terraform-state-readonly-user"
  force_destroy = true
}