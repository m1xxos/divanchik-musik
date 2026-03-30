resource "yandex_iam_service_account" "divanchik_k8s_account" {
  name        = "divanchik-k8s-account"
  description = "Service account for the Divanchik Music Kubernetes cluster"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_clusters_agent" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = var.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.divanchik_k8s_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc_public_admin" {
  # Сервисному аккаунту назначается роль "vpc.publicAdmin".
  folder_id = var.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.divanchik_k8s_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images_puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.divanchik_k8s_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
  # Сервисному аккаунту назначается роль "kms.keys.encrypterDecrypter".
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.divanchik_k8s_account.id}"
}

resource "yandex_iam_service_account" "gwin_k8s_account" {
  name        = "gwin-k8s-account"
  description = "SA for Divanvhik cluster Gwin LB"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc_public_admin_gwin" {
  folder_id = var.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.gwin_k8s_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "alb_editor_gwin" {
  folder_id = var.folder_id
  role      = "alb.editor"
  member    = "serviceAccount:${yandex_iam_service_account.gwin_k8s_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "certificate_manager_certificates_downloader_gwin" {
  folder_id = var.folder_id
  role      = "certificate-manager.certificates.downloader"
  member    = "serviceAccount:${yandex_iam_service_account.gwin_k8s_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "certificate_manager_editor_gwin" {
  folder_id = var.folder_id
  role      = "certificate-manager.editor"
  member    = "serviceAccount:${yandex_iam_service_account.gwin_k8s_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "compute_viewer_gwin" {
  folder_id = var.folder_id
  role      = "compute.viewer"
  member    = "serviceAccount:${yandex_iam_service_account.gwin_k8s_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_viewer_gwin" {
  folder_id = var.folder_id
  role      = "k8s.viewer"
  member    = "serviceAccount:${yandex_iam_service_account.gwin_k8s_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "smart_web_security_editor_gwin" {
  folder_id = var.folder_id
  role      = "smart-web-security.editor"
  member    = "serviceAccount:${yandex_iam_service_account.gwin_k8s_account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "logging_writer_gwin" {
  folder_id = var.folder_id
  role      = "logging.writer"
  member    = "serviceAccount:${yandex_iam_service_account.gwin_k8s_account.id}"
}
