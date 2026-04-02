data "yandex_alb_load_balancer" "gwin-gateway-gwin-divanchik-gateway" {
  load_balancer_id = "ds7ms6lsr6e5rq8ta8tt"
}

resource "cloudflare_dns_record" "divanchik_record" {
  zone_id = var.cf_zone_id
  name    = "divanchik.m1xxos.online"
  type    = "A"
  content = data.yandex_alb_load_balancer.gwin-gateway-gwin-divanchik-gateway.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
  ttl     = 3600
}

resource "cloudflare_dns_record" "divanchik_record_extra" {
  zone_id = var.cf_zone_id
  name    = "*.divanchik.m1xxos.online"
  type    = "CNAME"
  content = cloudflare_dns_record.divanchik_record.name
  ttl     = 3600
}
