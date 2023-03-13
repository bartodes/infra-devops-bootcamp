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
    instance_type   = var.root_instance_type
    key_name        = var.root_key_name

    ec2_user_data   = <<EOF
    #!/bin/bash
    echo "Instalacion de Jenkins"
    EOF
}

module "sg_root" {
    source = "./sg"

    vpc_id      = module.vpc_root.vpc_id

    environment = var.root_environment
    sg_name     = var.root_sg_name
}