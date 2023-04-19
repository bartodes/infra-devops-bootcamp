resource "kubernetes_namespace" "argocd" {
    metadata {
        name = "argocd"
    }
}

resource "helm_release" "argocd" {
    name       = "argocd-helm"
    namespace  = kubernetes_namespace.argocd.metadata.0.name

    repository = "https://argoproj.github.io/argo-helm"
    chart      = "argo-cd"
    values     = [var.values_file]
}