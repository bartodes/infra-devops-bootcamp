variable "endpoint" {
    type = string
    description = "The cluster endpoint."
}

variable "ca_certificate" {
    type = null
    description = "The base64 cluster certificate."
}

variable "values_file" {
    type = null
    description = "The file of argocd app."
}