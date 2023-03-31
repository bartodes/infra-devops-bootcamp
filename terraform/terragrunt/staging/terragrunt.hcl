terraform {
    source = "../../"
}


inputs = {
    root_environment = "staging"
    
    root_vpc_name = "staging-vpc"

    root_ec2_name          = "staging-jenkins-ec2"
    root_ec2_instance_type = "t3.medium"
    root_key_name          = "tf-devops" #Create a key pair before
    
    root_sg_name  = "staging-jenkins-sg"    
    
    root_cluster_name              = "staging-cluster"
    root_cluster_version           = "1.24"
    root_node_group_instances_type = ["t2.micro"]
}


include {
    path = find_in_parent_folders()
}