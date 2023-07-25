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

variable "root_ec2_instance_type" {
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

variable "root_cluster_name" {
  description = "The name of the cluster."
  type        = string
}

variable "root_cluster_version" {
  description = "The version of the cluster."
  type        = string
}

variable "root_node_group_instances_type" {
  description = "The node group instances type."
  type        = list(string)
}