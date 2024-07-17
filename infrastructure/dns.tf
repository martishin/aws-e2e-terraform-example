# 1. Route 53 Hosted Zone
resource "aws_route53_zone" "primary" {
  name = "martishin.com"
}

# 2. Route 53 Alias Record
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.martishin.com"
  type    = "A"

  alias {
    name                   = aws_lb.web_server_lb.dns_name
    zone_id                = aws_lb.web_server_lb.zone_id
    evaluate_target_health = true
  }
}
