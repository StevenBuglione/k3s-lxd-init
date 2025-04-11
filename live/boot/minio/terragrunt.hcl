// live/dev/remote-state/terragrunt.hcl
include "env" {
  path = "../_env/app.hcl"
  expose = true
}

dependency "secrets" {
  config_path = "../one-password"

  mock_outputs = {
    secret_data = {
      username = "mock-user"
      password = "mock-password"
      url = "mock-server"
      endpoint = "mock-endpoint"
    }
    vault_id = "mock-vault-id"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

generate "provider" {
  path      = "provider_minio.tf"
  if_exists = "overwrite"
  contents  = <<EOF
  provider "minio" {
    minio_server = "${dependency.secrets.outputs.secret_data["endpoint"]}"
    minio_user   = "${dependency.secrets.outputs.secret_data["username"]}"
    minio_password = "${dependency.secrets.outputs.secret_data["password"]}"
  }
EOF
}

terraform {
  source = "../../../infrastructure/modules/minio"
}

inputs = {
  minio_server = "${dependency.secrets.outputs.secret_data["endpoint"]}"
  state_bucket_name = include.env.locals.bucket_name
  vault_name = dependency.secrets.outputs.vault_id
}