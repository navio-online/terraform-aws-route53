# --------------------------------------------------------
# CREATE Route53 record for the instance
# --------------------------------------------------------
resource "aws_route53_zone" "this_public" {
  count = (var.zone_id == "none" && var.vpc_id == "none") ? 1 : 0
  name = var.domain
  comment = var.description

  tags = merge(var.tags, map("Name", var.domain))
}

resource "aws_route53_zone" "this_private" {
  count = (var.zone_id == "none" && var.vpc_id != "none") ? 1 : 0
  name = var.domain
  comment = var.description

  vpc {
    vpc_id = var.vpc_id
  }

  tags = merge(var.tags, map("Name", var.domain))
}

resource "aws_route53_record" "that" {
  count = var.zone_id != "none" && length(var.records["names"]) > 0 ? length(var.records["names"]) : 0
  zone_id = var.zone_id
  name = "${element(var.records["names"], count.index)}${var.domain}"
  type = element(var.records["types"], count.index)
  ttl = element(var.records["ttls"], count.index)
  records = split(",", element(var.records["values"], count.index))
}
