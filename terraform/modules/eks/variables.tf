variable "environment" {
  description = "The environment of the file"
  type        = string
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of the cluster"
  type        = string
}

variable "vpc_id" {
  description = "The id of the vpc"
  type        = string
}

variable "private_subnets_cluster" {
  description = "The private subnets id for the cluster"
  type        = list(string)
}

variable "private_subnets_control_plane" {
  description = "The private subnets id for the control plane"
  type        = list(string)
}

variable "node_group_instances_type" {
  description = "The node group instances"
  type        = list(string)
}