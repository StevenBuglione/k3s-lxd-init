// live/dev/secrets/terragrunt.hcl
terraform {
  source = "../../../infrastructure/modules/secrets"
}

inputs = {
  vault_name = "Home-Lab"
  item_title = "minio"
}
