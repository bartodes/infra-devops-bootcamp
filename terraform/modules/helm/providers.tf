terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }

        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "2.19.0"
        }
        
        helm = {
            source = "hashicorp/helm"
            version = "2.9.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

provider "kubernetes" {
    host = var.endpoint
    
    cluster_ca_certificate = base64decode(var.ca_certificate)
    
    exec {
        api_version = "client.authentication.k8s.io/v1beta1"
        args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
        command     = "aws"
    }
}

provider "helm" {
    kubernetes {
        host = var.endpoint

        cluster_ca_certificate = base64decode(var.ca_certificate)
        
        exec {
            api_version = "client.authentication.k8s.io/v1beta1"
            args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
            command     = "aws"
        }
    }
}