module "jenkins" {
  source = "./modules/jenkins"

ami_id = "ami-1234567890"
instance_type = "t2.micro"
key_name = "my-ec2-keypair"
subnet_id = "subnet-1234567890"
}