// live/dev/secrets/terragrunt.hcl
terraform {
  source = "../../../infrastructure/modules/one-password"
}

inputs = {
  vault_name = "Home-Lab"
  secret_name = "minio"
}
