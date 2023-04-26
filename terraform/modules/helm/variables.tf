variable "cluster_endpoint" {
    type = string
    description = "The cluster endpoint."
}

variable "cluster_ca_certificate" {
    description = "The base64 cluster certificate."
}

variable "cluster_name" {
    type = string
    description = "The name of the cluster."
}

variable "cluster_oidc_provider_url" {
    type = string
    description = "The Open ID Connect identity provider."
}