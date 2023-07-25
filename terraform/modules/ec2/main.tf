module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.ec2_name

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  monitoring             = true
  vpc_security_group_ids = var.ec2_sg
  subnet_id              = var.private_subnets
  user_data              = var.ec2_user_data

  tags = {
    Terraform   = "true"
    Name        = var.ec2_name
    Environment = var.environment
  }
}