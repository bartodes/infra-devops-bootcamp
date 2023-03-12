# Creación del ec2 instancia
resource "aws_instance" "jenkins_server" {
  ami                         = var.jenkins_ami
  instance_type               = "t2.micro"
  key_name                    = "jenkins-key"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins_traffic.id]
  subnet_id                   = aws_subnet.jenkins_public_subnet.id

  # Instalación de Java y Jenkins
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum -y install jenkins java-1.8.0-openjdk-devel",
      "sudo yum -y install wget",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum upgrade -y",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins",
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("key/jenkins-key.pem")
  }
  tags = {
    "Name" = "Jenkins-Server"
  }
}
