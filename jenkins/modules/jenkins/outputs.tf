output "jenkins_public_ip" {
  description = "Dirección IP pública de la instancia EC2 de Jenkins"
  value       = aws_instance.jenkins.public_ip
}
