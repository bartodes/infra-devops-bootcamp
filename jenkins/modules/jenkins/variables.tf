variable "ami_id" {
  description = "AMI ID para la instancia EC2 de Jenkins"
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para Jenkins"
}

variable "key_name" {
  description = "Nombre de la clave SSH para acceder a la instancia EC2 de Jenkins"
}

variable "subnet_id" {
  description = "ID de la subred donde se creará la instancia EC2 de Jenkins"
}
