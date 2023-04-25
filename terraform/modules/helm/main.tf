module "iam_assumable_role_oidc" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
    version = "5.17.0"

    create_role                   = true
    role_name                     = "k8s-argocd-admin"
    provider_url                  = var.cluster_oidc_provider_url
    role_policy_arns              = []
    oidc_fully_qualified_subjects = ["system:serviceaccount:argocd:argocd-server", "system:serviceaccount:argocd:argocd-application-controller"]
}

resource "kubernetes_namespace" "argocd" {
    metadata {
        name = "argocd"
    }
}

resource "helm_release" "argocd" {
    name       = "argocd-helm"
    namespace  = kubernetes_namespace.argocd.metadata.0.name

    repository = "https://argoproj.github.io/argo-helm"
    chart      = "argocd"
    values     = [var.values_file]

    set {
        name  = "server.service.type"
        value = "LoadBalancer"
    }

    set {
        name  = "server.configEnabled"
        value = "true"
    }

    set {
        name  = "server.name"
        value = "argocd-server"
    }

    set {
        name  = "server.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
        value = module.iam_assumable_role_oidc.iam_role_arn
    }

    set {
        name  = "controller.args.appResyncPeriod"
        value = "30"
    }

    set {
        name  = "controller.args.repoServerTimeoutSeconds"
        value = "15"
    }

    depends_on = [
        kubernetes_namespace.argocd,
        module.iam_assumable_role_oidc
    ]
}