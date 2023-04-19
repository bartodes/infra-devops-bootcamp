variable "cluster_endpoint" {
    type = string
    description = "The cluster endpoint."
}

variable "cluster_ca_certificate" {
    type = null
    description = "The base64 cluster certificate."
}

variable "values_file" {
    type = null
    description = "The file of argocd app."
}