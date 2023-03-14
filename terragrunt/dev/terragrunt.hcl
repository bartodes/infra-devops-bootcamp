terraform {
    source = "../../terraform/"
}

inputs = {
    root_environment = "env"
    
    root_vpc_name = "env-vpc"

    root_ec2_name          = "env-jenkins-ec2"
    root_ec2_instance_type = "t2.micro"
    root_key_name          = "default"
    
    root_sg_name  = "env-jenkins-sg"    
    
    root_cluster_name              = "env-cluster"
    root_cluster_version           = "1.24"
    root_node_group_instances_type = ["t2.micro"]
}

// include {
//     path = find_in_parent_folders()
// }