data "http" "project_dev_yaml" {
  url = var.argo_project_dev_url
}

data "http" "root_app_dev_yaml" {
  url = var.argo_root_app_dev_url
}