terraform {
  backend "s3" {
    bucket                      = "terraform-state-boot"
    key                         = "terraform/state/terraform.tfstate"
    region                      = "us-east-1"
    endpoints                   = {
      s3 = "http://10.10.10.7:9768"
    }
    access_key                  = "terraform-state-ci-cd-user"
    secret_key                  = "5t_-Gc5cR-Jt2ib9R4FLv64XkNxCMw6L7ZT4eaxDGpL3auZzoR5teA=="
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "echo 'MinIO backend configuration test successful!'"
  }
}

output "test_completed" {
  value = "Backend configuration test completed successfully"
}