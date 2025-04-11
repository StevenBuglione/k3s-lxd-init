terraform {
  required_providers {
    onepassword = {
      source  = "1password/onepassword"
      version = ">= 2.1.2"
    }
  }
}

provider "onepassword" {
  # Using 1Password Connect – credentials are sourced from environment:
  # OP_CONNECT_HOST (URL of Connect server) and OP_CONNECT_TOKEN (API token)
  # This keeps secrets out of code&#8203;:contentReference[oaicite:3]{index=3}.
}