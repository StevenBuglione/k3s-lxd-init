// live/dev/remote-state/terragrunt.hcl
dependency "secrets" {
  config_path = "../secrets"

  # Add mock outputs to allow planning before secrets module is applied
  mock_outputs = {
    minio_user = "mock-user"
    minio_password = "mock-password"
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
  minio_user = "${dependency.secrets.outputs.minio_user}"
  minio_password = "${dependency.secrets.outputs.minio_password}"
}
EOF
}

terraform {
  source = "../../../infrastructure/modules/remote_state_backend"
}

inputs = {
  minio_user = dependency.secrets.outputs.minio_user
  minio_password = dependency.secrets.outputs.minio_password
  minio_server   = dependency.secrets.outputs.minio_server
  state_bucket_name      = "terraform-state-dev"
  vault_name = "a4nh24gpadwwnvcqnww3txokwy"
}
