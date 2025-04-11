// live/dev/secrets/terragrunt.hcl

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../infrastructure/modules/one-password"
}


inputs = {
  vault_name = "Home-Lab"
  secret_name = "minio"
}

