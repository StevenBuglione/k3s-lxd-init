resource "onepassword_item" "minio_backend_config" {
  vault    = var.vault_name
  title    = "MinIO Terraform Backend - ${var.state_bucket_name}"
  category = "secure_note"

  section {
    label = "Backend Configuration"

    field {
      label = "bucket"
      value = var.state_bucket_name
      type = "STRING"
    }

    field {
      label = "endpoint"
      value = var.minio_server
      type = "STRING"
    }

    field {
      label = "region"
      value = var.minio_region
      type = "STRING"
    }

    field {
      label = "access_key"
      value = minio_iam_user.cicd_user.name
      type = "STRING"
    }

    field {
      label = "secret_key"
      value = minio_iam_user.cicd_user.secret
      type = "STRING"
    }

    field {
      label = "skip_credentials_validation"
      value = "true"
      type = "STRING"
    }

    field {
      label = "skip_region_validation"
      value = "true"
      type = "STRING"
    }

    field {
      label = "force_path_style"
      value = "true"
      type = "STRING"
    }
  }
}