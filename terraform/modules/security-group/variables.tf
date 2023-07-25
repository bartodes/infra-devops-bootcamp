variable "environment" {
  description = "The name of the environment."
  type        = string
}

variable "sg_name" {
  description = "The name of the security group."
  type        = string
}

variable "web_ingress" {
  description = "A list of ingress rules."
  type = map(object({
    description = string
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    "80" = {
      description = "HTTP inbound traffic."
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    "443" = {
      description = "HTTPs inbound traffic."
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    "22" = {
      description = "Allow SSH inbound traffic."
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    "8080" = {
      description = "Allow inbound traffic for Jenkins."
      port        = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "vpc_id" {
  description = "The id of a VPC."
  type        = string
}