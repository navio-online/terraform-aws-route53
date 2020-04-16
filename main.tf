# --------------------------------------------------------
# CREATE Route53 record for the instance
# --------------------------------------------------------
resource "aws_route53_zone" "this_public" {
  count = (var.zone_id == "none" && var.vpc_id == "none") ? 1 : 0
  name = var.domain
  comment = var.description
}

resource "aws_route53_zone" "this_private" {
  count = (var.zone_id == "none" && var.vpc_id != "none") ? 1 : 0
  name = var.domain
  comment = var.description

  vpc {
    vpc_id = var.vpc_id
  }
}

# resource "aws_route53_record" "this" {
#   depends_on  = [ aws_route53_zone.this ]
#   count = var.zone_id == "false" && length(var.records["names"]) > 0 ? length(var.records["names"]) : 0
#   zone_id = var.zone_id != "false" ? var.zone_id : aws_route53_zone.this.0.zone_id
#   name = "${element(var.records["names"], count.index)}${var.domain}"
#   type = element(var.records["types"], count.index)
#   ttl = element(var.records["ttls"], count.index)
#   records = split(",", element(var.records["values"], count.index))
# }

# resource "aws_route53_record" "alias" {
#   depends_on  = [ aws_route53_zone.this ]
#   count = var.zone_id == "false" && length(var.aliases["names"]) > 0 ? length(var.aliases["names"]) : 0
#   zone_id = var.zone_id != "false" ? var.zone_id : aws_route53_zone.this.0.zone_id
#   name = "${element(var.aliases["names"], count.index)}${var.domain}"
#   type = "A"

#   alias {
#     name  = element(var.aliases["values"], count.index)
#     zone_id = element(var.aliases["zones_id"], count.index)
#     evaluate_target_health = false
#   }

# }

resource "aws_route53_record" "that" {
  count = var.zone_id != "none" && length(var.records["names"]) > 0 ? length(var.records["names"]) : 0
  zone_id = var.zone_id
  name = "${element(var.records["names"], count.index)}${var.domain}"
  type = element(var.records["types"], count.index)
  ttl = element(var.records["ttls"], count.index)
  records = split(",", element(var.records["values"], count.index))
}

# resource "aws_route53_record" "alias_imported" {
#   count = "${var.zone_id != "false" && length(var.aliases["names"]) > 0 ? length(var.aliases["names"]) : 0}"
#   zone_id = "${var.zone_id}"
#   name = "${element(var.aliases["names"], count.index)}${var.domain}"
#   type = "A"

#   alias {
#     name  = "${element(var.aliases["values"], count.index)}"
#     zone_id = "${element(var.aliases["zones_id"], count.index)}"
#     evaluate_target_health = false
#   }

# }
