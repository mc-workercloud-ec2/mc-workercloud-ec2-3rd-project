
data "aws_route53_zone" "campinggo" {
  name         = "${var.domain}."
}
resource "aws_route53_record" "admin_record" {
  zone_id = data.aws_route53_zone.campinggo.zone_id
  name    = "www.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.web_alb.dns_name]
}

resource "aws_route53_record" "applicant_record" {
  zone_id = data.aws_route53_zone.campinggo.zone_id
  name    = "applicant.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.was_alb.dns_name]
}
resource "aws_route53_record" "jobposting_record" {
  zone_id = data.aws_route53_zone.campinggo.zone_id
  name    = "jobposting.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.was_alb.dns_name]
}
resource "aws_route53_record" "zabbix_record" {
  zone_id = data.aws_route53_zone.campinggo.zone_id
  name    = "zabbix.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.web_alb.dns_name]
}
resource "aws_route53_record" "grafana_record" {
  zone_id = data.aws_route53_zone.campinggo.zone_id
  name    = "grafana.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.web_alb.dns_name]
}