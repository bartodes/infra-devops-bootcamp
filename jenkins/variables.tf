# Variables region
variable "region" {
  description = "aws"
  type        = string
  default     = "us-east-1"
}

# Lista de port para el security group
variable "ingressrules" {
  type    = list(number)
  default = [8080, 22]
}

# AMI para el EC2
variable "jenkins_ami" {
  description = "AMi para el EC2"
  default     = "ami-005f9685cb30f234b"
}
