resource "yandex_vpc_network" "divanchik" {
  name        = "divanchik-network"
  description = "Divanchik music k8s network"
}

resource "yandex_vpc_subnet" "divanchik-d" {
  network_id     = yandex_vpc_network.divanchik.id
  name           = "divanchik-d"
  zone           = "ru-central1-d"
  v4_cidr_blocks = "192.168.1.0/24"
}