# --------------------------------------------------------
# CREATE Route53 Hosted Zone 
# --------------------------------------------------------
resource "aws_route53_zone" "this_public" {
  count = (var.zone_id == "none" && var.vpc_id == "none") ? 1 : 0

  name    = var.domain
  comment = var.description
  tags    = merge(var.tags, map("Name", var.domain))
}

resource "aws_route53_zone" "this_private" {
  count = (var.zone_id == "none" && var.vpc_id != "none") ? 1 : 0

  name    = var.domain
  comment = var.description
  tags    = merge(var.tags, map("Name", var.domain))

  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "this" {
  count   = var.zone_id != "none" && length(var.records) > 0 ? 1 : 0

  zone_id = var.zone_id

  name    = "${element(var.records, count.index)["name"]}.${var.domain}"
  type    = element(var.records, count.index)["type"]
  ttl     = element(var.records, count.index)["ttl"]
  records = element(var.records, count.index)["values"]
}

resource "aws_route53_record" "alias" {
  count   = var.zone_id != "none" && length(var.aliases) > 0 ? 1 : 0

  zone_id = var.zone_id
  name    = "${element(var.aliases, count.index)["name"]}.${var.domain}"
  type    = "A"

  alias {
    name    = element(var.aliases, count.index)["value"]
    zone_id = element(var.aliases, count.index)["zone_id"]
    evaluate_target_health = false
  }
}
