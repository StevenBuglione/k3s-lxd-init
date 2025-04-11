resource "minio_iam_group_user_attachment" "admin_membership" {
  group_name = minio_iam_group.admin_group.name
  user_name  = minio_iam_user.admin_user.name
}

resource "minio_iam_group_user_attachment" "rw_membership" {
  group_name = minio_iam_group.rw_group.name
  user_name  = minio_iam_user.cicd_user.name
}

resource "minio_iam_group_user_attachment" "ro_membership" {
  group_name = minio_iam_group.ro_group.name
  user_name  = minio_iam_user.readonly_user.name
}