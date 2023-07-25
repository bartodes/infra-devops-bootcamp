terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.19.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }

    # argocd = {
    #     source = "jojand/argocd"
    #     version = "2.3.2"
    # }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host = var.cluster_endpoint

  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host = var.cluster_endpoint

    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}

# provider "argocd" {
#     kubernetes {
#         host        = var.cluster_endpoint

#         cluster_ca_certificate = base64decode(var.cluster_ca_certificate)

#         exec {
#             api_version = "client.authentication.k8s.io/v1beta1"
#             args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
#             command     = "aws"
#         }
#     }
#     # ArgoCd server. Load balancer dns hostname with port 443 (you have to add into /etc/hosts file: <IP_OF_LB> <HOST_NAME_OF_LB>)
#     server_addr = "lb.aws:443"
#     # ArgoCd credentials
#     username = "admin"
#     password = "" #The initial admin password decoded
#     # Insecure flag to avoid using a tls cert
#     insecure = true
# }