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

# resource "aws_route53_record" "this_public" {
#   depends_on  = [ aws_route53_zone.this_public ]
#   count = length(var.records["names"])
#   zone_id = var.zone_id != "none" ? var.zone_id : aws_route53_zone.this_public.0.zone_id
#   name = "${element(var.records["names"], count.index)}${var.domain}"
#   type = element(var.records["types"], count.index)
#   ttl = element(var.records["ttls"], count.index)
#   records = split(",", element(var.records["values"], count.index))
# }

resource "aws_route53_record" "this" {
  count   = var.zone_id != "none" && length(var.records["values"]) > 0 ? 1 : 0

  zone_id = var.zone_id
  name    = "${var.records["name"]}${var.domain}"
  type    = var.records["type"]
  ttl     = var.records["ttl"]
  records = sort(var.records["values"])
}
