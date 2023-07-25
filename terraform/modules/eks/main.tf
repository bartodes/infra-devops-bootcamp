module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.13.1"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets_cluster
  control_plane_subnet_ids = var.private_subnets_control_plane

  iam_role_additional_policies = {
    AmazonEKSServicePolicy = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  }

  eks_managed_node_groups = {
    green = {
      min_size     = 1
      max_size     = 3
      desired_size = 1

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
    }
  }

  enable_irsa = true

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}