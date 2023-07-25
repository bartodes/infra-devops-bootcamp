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
  name      = "argocd-helm"
  namespace = kubernetes_namespace.argocd.metadata.0.name

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  values     = [file("${path.module}/values/values.yaml")]

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

  depends_on = [
    kubernetes_namespace.argocd,
    module.iam_assumable_role_oidc
  ]
}

# Attempting to create the application from terraform, instead of manually applying the yaml file into argocd server.

# resource "argocd_application" "api-store" {
#     metadata {
#         name = "dev-app"
#         namespace = "argocd"
#     }

#     spec {
#         destination {
#             namespace = "dev-api"
#             server = "https://kubernetes.default.svc"
#         }
#         source {
#             path = "environments/dev"
#             repo_url = "https://github.com/bartodes/k8s-devops-bootcamp.git"
#             target_revision = "HEAD"
#         }
#         sync_policy {
#             sync_options = [ "CreateNamespace=true" ]
#             automated = {
#                 prune       = true
#                 self_heal   = true
#             }
#         }
#     }

#     depends_on = [
#         helm_release.argocd
#     ]
# }