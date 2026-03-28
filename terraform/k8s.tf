resource "yandex_kubernetes_cluster" "k8s_divanchik_cluster" {
  name        = "divanchik-cluster"
  description = "Divanchik musik cluster"
  network_id  = yandex_vpc_network.divanchik.id
  master {
    version   = "1.33"
    public_ip = true
    master_location {
      zone      = yandex_vpc_subnet.divanchik_a.zone
      subnet_id = yandex_vpc_subnet.divanchik_a.id
    }
    master_location {
      zone      = yandex_vpc_subnet.divanchik_b.zone
      subnet_id = yandex_vpc_subnet.divanchik_b.id
    }
    master_location {
      zone      = yandex_vpc_subnet.divanchik_d.zone
      subnet_id = yandex_vpc_subnet.divanchik_d.id
    }
    security_group_ids = [yandex_vpc_security_group.divanchik_k8s_sg.id]
    maintenance_policy {
      auto_upgrade = true
      maintenance_window {
        start_time = "22:00"
        duration   = "3h"
      }
    }
  }
  service_account_id      = yandex_iam_service_account.divanchik_k8s_account.id
  node_service_account_id = yandex_iam_service_account.divanchik_k8s_account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_clusters_agent,
    yandex_resourcemanager_folder_iam_member.vpc_public_admin,
    yandex_resourcemanager_folder_iam_member.images_puller,
    yandex_resourcemanager_folder_iam_member.encrypterDecrypter
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.divanchik_key.id
  }
  release_channel = "REGULAR"
  network_implementation {
    cilium {

    }
  }
}