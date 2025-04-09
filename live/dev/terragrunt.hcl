locals {
  environment = "dev"
  bucket_name = "terraform-state-${local.environment}"
}

dependency "secrets" {
  # Reference the secrets stack to get MinIO credentials.
  config_path = "./secrets"
  # (Terragrunt will ensure this dependency is applied before others that need it.)
}

generate "backend" {
  path      = "backend.tf"        # Terraform backend config file to generate
  if_exists = "overwrite"         # Overwrite if it exists (to handle updates)
  contents  = <<-EOF
    terraform {
      backend "s3" {
        bucket = "${local.bucket_name}"
        key    = "${path_relative_to_include()}/terraform.tfstate"
        region = "us-east-1"
        endpoints = { s3 = "${dependency.secrets.outputs.minio_server}" }
        access_key = "${dependency.secrets.outputs.minio_access_key}"
        secret_key = "${dependency.secrets.outputs.minio_secret_key}"
        skip_credentials_validation = true
        skip_requesting_account_id  = true
        skip_metadata_api_check     = true
        skip_region_validation      = true
        use_path_style = true
      }
    }
  EOF
}