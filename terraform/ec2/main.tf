module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.ec2_name

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  #monitoring             = true
  #vpc_security_group_ids = 
  #subnet_id              = module.vpc.private_subnets[1]

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
