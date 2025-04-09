# Generate IAM policy document for full admin access on the state bucket
data "minio_iam_policy_document" "admin_policy_doc" {
  statement {
    sid     = "AdminFullAccess"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      minio_s3_bucket.state.arn,
      "${minio_s3_bucket.state.arn}/*"
    ]
  }
}

# Generate IAM policy document for read-write access on the state bucket
data "minio_iam_policy_document" "rw_policy_doc" {
  statement {
    sid     = "StateObjectAccess"
    effect  = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = ["${minio_s3_bucket.state.arn}/*"]  # state objects
  }
  statement {
    sid     = "StateBucketListing"
    effect  = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [minio_s3_bucket.state.arn]
  }
}

# Generate IAM policy document for read-only access on the state bucket
data "minio_iam_policy_document" "ro_policy_doc" {
  statement {
    sid     = "StateObjectRead"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${minio_s3_bucket.state.arn}/*"]  # state objects
  }
  statement {
    sid     = "StateBucketListing"
    effect  = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [minio_s3_bucket.state.arn]         # bucket-level read actions
  }
}

# Create IAM policies in MinIO using the documents above
resource "minio_iam_policy" "admin_policy" {
  name   = "terraform-state-admin"
  policy = data.minio_iam_policy_document.admin_policy_doc.json
}
resource "minio_iam_policy" "rw_policy" {
  name   = "terraform-state-rw"
  policy = data.minio_iam_policy_document.rw_policy_doc.json
}
resource "minio_iam_policy" "ro_policy" {
  name   = "terraform-state-readonly"
  policy = data.minio_iam_policy_document.ro_policy_doc.json
}
