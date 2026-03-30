data "kubernetes_secret_v1" "argo-admin-pass" {
  metadata {
    namespace = "argocd"
    name      = "argocd-initial-admin-secret"
  }
}

resource "argocd_repository" "divanchik" {
  repo = "https://github.com/m1xxos/divanchik-musik"
}

resource "argocd_application_set" "helm-apps" {
  metadata {
    name = "helm-apps"
  }
  spec {
    generator {
      git {
        repo_url = argocd_repository.divanchik.repo
        revision = "HEAD"
        directory {
          path = "apps/*"
        }
      }
    }
    template {
      metadata {
        name = "{{path.basename}}-app"
      }
      spec {
        source {
          repo_url        = argocd_repository.divanchik.repo
          target_revision = "HEAD"
          path            = "{{path}}"
        }

        destination {
          server    = "https://kubernetes.default.svc"
          namespace = "{{path.basename}}"
        }

        sync_policy {
          sync_options = [
            "CreateNamespace=true"
          ]
          automated {
            prune     = true
            self_heal = true
          }
        }
      }
    }
  }
}
