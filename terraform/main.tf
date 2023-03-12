module "vpc_root" {
    source = "./network"

    environment = var.root_environment
    vpc_name = var.root_vpc_name
}

module "ec2_instance_root" {
    source = "./ec2"

    #                 Outputs from a module
    private_subnets = module.vpc_main.private_subnets_id[0]      
    #vpc_sg          = module # id output from security group module     

    #                 Variable in the variables.tf
    environment     = var.root_environment            
    ec2_name        = var.root_ec2_name                          
    instance_type   = var.root_ec2_intsance_type
    key_name        = var.root_key_name
}