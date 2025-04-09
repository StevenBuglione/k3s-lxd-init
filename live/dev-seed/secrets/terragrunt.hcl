// live/dev/secrets/terragrunt.hcl
terraform {
  source = "../../../infrastructure/modules/secrets"
}

inputs = {
  vault_id = "a4nh24gpadwwnvcqnww3txokwy"
  item_title = "minio"
}
