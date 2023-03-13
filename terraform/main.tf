module "vpc_root" {
    source = "./network"

    environment = var.root_environment
    vpc_name = var.root_vpc_name
}

module "ec2_instance_root" {
    source = "./ec2"

    private_subnets = module.vpc_root.private_subnets_id[0]      
    ec2_sg          = [module.sg_root.sg_id]

    environment     = var.root_environment            
    ec2_name        = var.root_ec2_name                          
    instance_type   = var.root_ec2_instance_type
    key_name        = var.root_key_name

    ec2_user_data   = <<EOF
    #!/bin/bash
    echo "Instalacion de Jenkins"
    EOF
}

module "sg_root" {
    source = "./sg"

    vpc_id = module.vpc_root.vpc_id

    environment = var.root_environment
    sg_name     = var.root_sg_name
}

module "eks_root" {
    source = "./eks"

    vpc_id                        = module.vpc_root.vpc_id
    private_subnets_cluster       = module.vpc_root.private_subnets_id
    private_subnets_control_plane = module.vpc_root.private_subnets_id

    node_group_instances_type = var.root_node_group_instances_type
    environment               = var.root_environment
    cluster_name              = var.root_cluster_name
    cluster_version           = var.root_cluster_version
}