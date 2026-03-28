resource "yandex_vpc_network" "divanchik" {
  name        = "divanchik-network"
  description = "Divanchik music k8s network"
}

resource "yandex_vpc_subnet" "divanchik_a" {
  network_id     = yandex_vpc_network.divanchik.id
  name           = "divanchik-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.5.0.0/16"]
  description    = "Divanchik music zone-a k8s subnet"
}

resource "yandex_vpc_subnet" "divanchik_b" {
  network_id     = yandex_vpc_network.divanchik.id
  name           = "divanchik-b"
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["10.6.0.0/16"]
  description    = "Divanchik music zone-b k8s subnet"
}

resource "yandex_vpc_subnet" "divanchik_d" {
  network_id     = yandex_vpc_network.divanchik.id
  name           = "divanchik-d"
  zone           = "ru-central1-d"
  v4_cidr_blocks = ["10.7.0.0/16"]
  description    = "Divanchik music zone-d k8s subnet"
}
