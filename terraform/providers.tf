terraform {
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = ">= 2.5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.0"
    }
  }
}

provider "lxd" {
  remote {
    name = var.lxd_provider_config.name
    address = var.lxd_provider_config.address
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"

}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
