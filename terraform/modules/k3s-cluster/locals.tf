locals {
  kubeconfig = yamlencode({
    apiVersion      = "v1"
    kind            = "Config"
    current-context = var.cluster_domain
    contexts = [{
      context = {
        cluster = var.cluster_domain
        name : "master-user"
      }
      name = var.cluster_domain
    }]
    clusters = [{
      cluster = {
        certificate-authority-data = base64encode(module.k3s.kubernetes.cluster_ca_certificate)
        server                     = "https://${var.server_nodes[0].ip}:6443"
      }
      name = var.cluster_domain
    }]
    users = [{
      user = {
        client-certificate-data : base64encode(module.k3s.kubernetes.client_certificate)
        client-key-data : base64encode(module.k3s.kubernetes.client_key)
      }
      name : "master-user"
    }]
  })
}