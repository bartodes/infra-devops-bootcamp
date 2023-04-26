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
    config_path = "~/.kube/config"
}