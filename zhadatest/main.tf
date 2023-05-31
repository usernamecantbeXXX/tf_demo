# https://developer.hashicorp.com/terraform/tutorials/kubernetes

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "/etc/rancher/k3s/k3s.yaml"
}

resource "kubernetes_namespace" "test" {
  metadata {
    name = "hacker-company"
  }
}

resource "kubernetes_pod" "frontend" {
  metadata {
    name      = "frontend"
    namespace = "hacker-company"
  }
  spec {
    container {
      name  = "nginx"
      image = "nginx:latest"
      liveness_probe {
        exec {
          command = ["nginx", "-t"]
        }
      }
    }
  }
}