// live/dev/remote-state/terragrunt.hcl
dependency "secrets" {
  config_path = "../secrets"

  # Add mock outputs to allow planning before secrets module is applied
  mock_outputs = {
    minio_access_key = "mock-access-key"
    minio_secret_key = "mock-secret-key"
    minio_server = "mock-server"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

generate "provider" {
  path      = "provider_minio.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "minio" {
  minio_server     = "${dependency.secrets.outputs.minio_server}"
  minio_access_key = "${dependency.secrets.outputs.minio_access_key}"
  minio_secret_key = "${dependency.secrets.outputs.minio_secret_key}"
}
EOF
}

terraform {
  source = "../../../infrastructure/modules/remote_state_backend"
}

inputs = {
  minio_access_key = dependency.secrets.outputs.minio_access_key
  minio_secret_key = dependency.secrets.outputs.minio_secret_key
  minio_server   = dependency.secrets.outputs.minio_server
  state_bucket_name      = "terraform-state-dev"
}
