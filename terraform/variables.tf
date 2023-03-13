variable "root_environment" {
    description = "The name of the environment."
    type        = string
}

variable "root_vpc_name" {
    description = "The name of the vpc."
}

variable "root_ec2_name" {
    description = "The name of the ec2 server."
    type        = string 
}

variable "root_ec2_intsance_type" {
    description = "The instance type of the ec2 server."
    type        = string
}

variable "root_key_name" {
    description = "The name of the key pair."
    type        = string
}

variable "root_sg_name" {
    description = "The name of the security group."
}