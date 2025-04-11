# Create IAM groups
resource "minio_iam_group" "admin_group" {
  name = "terraform-state-admin"
}

resource "minio_iam_group" "rw_group" {
  name = "terraform-state-ci-cd"
}

resource "minio_iam_group" "ro_group" {
  name = "terraform-state-readonly"
}


resource "minio_iam_group_policy_attachment" "admin_group_attach" {
  group_name  = minio_iam_group.admin_group.name
  policy_name = minio_iam_policy.admin_policy.id
}

resource "minio_iam_group_policy_attachment" "rw_group_attach" {
  group_name  = minio_iam_group.rw_group.name
  policy_name = minio_iam_policy.rw_policy.id
}

resource "minio_iam_group_policy_attachment" "ro_group_attach" {
  group_name  = minio_iam_group.ro_group.name
  policy_name = minio_iam_policy.ro_policy.id
}