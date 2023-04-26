output "cluster_name" {
    value = module.eks.cluster_name
    description = "The name of the cluster."
}

output "cluster_ca_certificate" {
    value = module.eks.cluster_certificate_authority_data
    description = "The CA certificate."
}

output "cluster_endpoint" {
    value = module.eks.cluster_endpoint
    description = "The cluster endpoint."
}

output "cluster_oidc_provider_url" {
    value = module.eks.oidc_provider
    description = "The Open ID Connect identity provider."
}