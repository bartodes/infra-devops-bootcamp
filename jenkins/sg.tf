# Creación de la VPC
resource "aws_vpc" "jenkins_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Jenkins-VPC"
  }
}

# Creación de la subred pública
resource "aws_subnet" "jenkins_public_subnet" {
  vpc_id            = aws_vpc.jenkins_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Jenkins-Subnet-Pública"
  }
}

# Grupo de seguridad
resource "aws_security_group" "jenkins_traffic" {
  name        = "jenkins_traffic"
  description = "Allow trafico y ssh para la entrada y salida"
  vpc_id      = aws_vpc.jenkins_vpc.id

  #inbound
  dynamic "ingress" {
    for_each = var.ingressrules
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Jenkins-SG"
  }
}
