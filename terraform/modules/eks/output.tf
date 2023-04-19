output "cluster_name" {
    value = module.eks.cluster_name
    description = "The name of the cluster."
}

output "cluster_ca_certificate" {
    value = module.eks.cluster_certificate_authority_data
}

output "cluster_endpoint" {
    value = module.eks.cluster_endpoint
}