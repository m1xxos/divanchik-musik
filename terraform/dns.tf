

resource "cloudflare_dns_record" "divanchik_record" {
  zone_id = var.cf_zone_id
  name    = "divanchik.m1xxos.online"
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_dns_record" "divanchik_record_extra" {
  zone_id = var.cf_zone_id
  name    = "*.divanchik.m1xxos.online"
  type    = "CNAME"
  content = cloudflare_dns_record.divanchik_record.name
  ttl     = 3600
}
