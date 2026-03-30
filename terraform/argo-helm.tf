resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "9.4.17"
  namespace        = "argocd"
  create_namespace = true
  values           = [file("./cfg/argo-values.yaml")]
}