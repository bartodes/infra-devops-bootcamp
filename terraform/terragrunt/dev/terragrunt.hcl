terraform {
    source = "../../"
}


inputs = {
    root_environment = "dev"
    
    root_vpc_name = "dev-vpc"

    root_ec2_name          = "dev-jenkins-ec2"
    root_ec2_instance_type = "t3.medium"
    root_key_name          = "tf-devops" #Create a key pair before
    
    root_sg_name  = "dev-jenkins-sg"    
    
    root_cluster_name              = "dev-cluster"
    root_cluster_version           = "1.26"
    root_node_group_instances_type = ["t3.medium"]
}


include {
    path = find_in_parent_folders()
}