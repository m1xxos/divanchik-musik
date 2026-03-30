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
    security_group_ids = [yandex_vpc_security_group.k8s-cluster-nodegroup-traffic.id, yandex_vpc_security_group.alb.id, yandex_vpc_security_group.k8s-cluster-traffic.id]
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

resource "yandex_kubernetes_node_group" "divanchik_a_k8s_ng" {
  name        = "divanchik-a-k8s-ng"
  description = "Divanchik musik zone a ng"
  cluster_id  = yandex_kubernetes_cluster.k8s_divanchik_cluster.id
  version     = "1.33"
  instance_template {
    name        = "dm-{instance.short_id}-{instance_group.id}"
    platform_id = "standard-v3"
    resources {
      cores         = 2
      core_fraction = 50
      memory        = 4
    }
    boot_disk {
      size = 64
      type = "network-ssd"
    }
    network_acceleration_type = "standard"
    network_interface {
      security_group_ids = [yandex_vpc_security_group.k8s-cluster-nodegroup-traffic.id, yandex_vpc_security_group.alb.id, yandex_vpc_security_group.nodegroup-backend.id, yandex_vpc_security_group.nodegroup-services-access.id, yandex_vpc_security_group.nodegroup-traffic.id]
      subnet_ids         = [yandex_vpc_subnet.divanchik_a.id]
      nat                = true
    }
    scheduling_policy {
      preemptible = true
    }
  }
  scale_policy {
    fixed_scale {
      size = 2
    }
  }
  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }
  deploy_policy {
    max_expansion   = 3
    max_unavailable = 1
  }
  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
    maintenance_window {
      start_time = "22:00"
      duration   = "5h"
    }
  }
}

resource "yandex_kubernetes_node_group" "divanchik_d_k8s_ng" {
  name        = "divanchik-d-k8s-ng"
  description = "Divanchik musik zone d ng"
  cluster_id  = yandex_kubernetes_cluster.k8s_divanchik_cluster.id
  version     = "1.33"
  instance_template {
    name        = "dm-{instance.short_id}-{instance_group.id}"
    platform_id = "standard-v3"
    resources {
      cores         = 2
      core_fraction = 50
      memory        = 4
    }
    boot_disk {
      size = 64
      type = "network-ssd"
    }
    network_acceleration_type = "standard"
    network_interface {
      security_group_ids = [yandex_vpc_security_group.k8s-cluster-nodegroup-traffic.id, yandex_vpc_security_group.alb.id, yandex_vpc_security_group.nodegroup-backend.id, yandex_vpc_security_group.nodegroup-services-access.id, yandex_vpc_security_group.nodegroup-traffic.id]
      subnet_ids         = [yandex_vpc_subnet.divanchik_d.id]
      nat                = true
    }
    scheduling_policy {
      preemptible = true
    }
  }
  scale_policy {
    fixed_scale {
      size = 1
    }
  }
  allocation_policy {
    location {
      zone = "ru-central1-d"
    }
  }
  deploy_policy {
    max_expansion   = 3
    max_unavailable = 1
  }
  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
    maintenance_window {
      start_time = "22:00"
      duration   = "5h"
    }
  }
}
