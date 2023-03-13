terraform {
    source = "../../terraform/"
}

inputs = {
    root_environment   = "env"
    
    root_vpc_name      = "env-vpc"
    root_ec2_name      = "env-jenkins-ec2"
    root_sg_name       = "env-jenkins-sg"    

    root_instance_type = "t2.micro"
    root_key_name      = "default"
}