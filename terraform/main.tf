module "vpc_root" {
    source = "./modules/vpc"

    environment = var.root_environment
    vpc_name = var.root_vpc_name
}


module "ec2_jenkins_root" {
    source = "./modules/ec2"

    private_subnets = module.vpc_root.private_subnets_id[0]      
    ec2_sg          = [module.sg_root.sg_id]

    environment     = var.root_environment            
    ec2_name        = var.root_ec2_name                          
    instance_type   = var.root_ec2_instance_type
    key_name        = var.root_key_name

    ec2_user_data   = file("user_data/jenkins.sh")
}


module "ec2_bastion_root" {
    source = "./modules/ec2"

    private_subnets = module.vpc_root.public_subnets_id[0]      
    ec2_sg          = [module.sg_root.sg_id]

    environment     = var.root_environment            
    ec2_name        = "bastion_server"                          
    instance_type   = var.root_ec2_instance_type
    key_name        = var.root_key_name

    ec2_user_data   = ""
}


module "sg_root" {
    source = "./modules/security-group"

    vpc_id = module.vpc_root.vpc_id

    environment = var.root_environment
    sg_name     = var.root_sg_name
}


module "eks_root" {
    source = "./modules/eks"

    vpc_id                        = module.vpc_root.vpc_id
    # private_subnets_cluster       = module.vpc_root.public_subnets_id
    # private_subnets_control_plane = module.vpc_root.public_subnets_id
    private_subnets_cluster       = module.vpc_root.private_subnets_id
    private_subnets_control_plane = module.vpc_root.private_subnets_id

    node_group_instances_type = var.root_node_group_instances_type
    environment               = var.root_environment
    cluster_name              = var.root_cluster_name
    cluster_version           = var.root_cluster_version
}


module "helm_root" {
    source = "./modules/helm"

    cluster_endpoint          = module.eks_root.cluster_endpoint
    cluster_ca_certificate    = module.eks_root.cluster_ca_certificate
    cluster_name              = module.eks_root.cluster_name
    cluster_oidc_provider_url = module.eks_root.cluster_oidc_provider_url
}

resource "null_resource" "clean_up_argocd_resources" {
    triggers = {
        eks_cluster_name = var.root_cluster_name
    }

    provisioner "local-exec" {
        command     = <<-EOT
        kubeconfig=/tmp/tf.clean_up_argocd.kubeconfig.yaml
        aws eks update-kubeconfig --name ${self.triggers.eks_cluster_name} --kubeconfig $kubeconfig
        rm -f /tmp/tf.clean_up_argocd_resources.err.log
        kubectl --kubeconfig $kubeconfig get Application -A -o name | xargs -I {} kubectl --kubeconfig $kubeconfig -n argocd patch -p '{"metadata":{"finalizers":null}}' --type=merge {} 2> /tmp/tf.clean_up_argocd_resources.err.log || true
        rm -f $kubeconfig
        EOT
        interpreter = ["bash", "-c"]
        when        = destroy
    } 
}