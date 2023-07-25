variable "environment" {
  description = "The name of the environment."
  type        = string
}

variable "ec2_name" {
  description = "The name of the ec2 instance."
  type        = string
}

variable "key_name" {
  description = "The name of a key pair."
  type        = string
}

variable "instance_type" {
  description = "The instance type of ec2 server."
  type        = string
}

variable "private_subnets" {
  description = "The id of the private subnets."
  type        = string
}

variable "ec2_sg" {
  description = "The ID of a security group."
  type        = list(string)
}

variable "ec2_user_data" {
  description = "The user data to provide when launching the instance."
}