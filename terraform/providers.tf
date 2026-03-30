terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.194.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.1"
    }
  }
  backend "s3" {
    endpoint                    = "https://storage.yandexcloud.net"
    region                      = "ru-central1"
    key                         = "divanchik-musik.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  zone = "ru-central-d"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
    config_context = "yc-${yandex_kubernetes_cluster.k8s_divanchik_cluster.name}"
  }
}