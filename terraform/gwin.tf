resource "yandex_iam_service_account_key" "gwin_key" {
  service_account_id = yandex_iam_service_account.gwin_k8s_account.id
}

resource "kubernetes_namespace_v1" "gwin" {
  metadata {
    name = "gwin"
  }
}

resource "kubernetes_secret" "gwin_sa_key" {
  metadata {
    name      = "gwin-sa-key"
    namespace = "gwin"
  }

  data = {
    "sa-key.json" = jsonencode({
      id                 = yandex_iam_service_account_key.gwin_key.id
      service_account_id = yandex_iam_service_account_key.gwin_key.service_account_id
      created_at         = yandex_iam_service_account_key.gwin_key.created_at
      key_algorithm      = yandex_iam_service_account_key.gwin_key.key_algorithm
      public_key         = yandex_iam_service_account_key.gwin_key.public_key
      private_key        = yandex_iam_service_account_key.gwin_key.private_key
    })
  }

  depends_on = [yandex_iam_service_account_key.gwin_key]
}