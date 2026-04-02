resource "yandex_cm_certificate" "divanchik" {
  name    = "divanchik"
  domains = ["divanchik.m1xxos.online", "*.divanchik.m1xxos.online"]
  managed {
    challenge_type  = "DNS_CNAME"
    challenge_count = 1
  }
}

resource "cloudflare_dns_record" "cert_record" {
  count   = yandex_cm_certificate.divanchik.managed[0].challenge_count
  zone_id = var.cf_zone_id
  name    = yandex_cm_certificate.divanchik.challenges[count.index].dns_name
  type    = yandex_cm_certificate.divanchik.challenges[count.index].dns_type
  content = yandex_cm_certificate.divanchik.challenges[count.index].dns_value
  ttl     = 60
}
