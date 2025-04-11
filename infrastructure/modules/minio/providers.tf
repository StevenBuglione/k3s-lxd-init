terraform {
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = ">= 3.3.0"
    }
    onepassword = {
      source  = "1password/onepassword"
      version = "= 2.1.1"
    }
  }
}