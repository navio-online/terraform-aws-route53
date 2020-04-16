output "zone_id" {
  value = var.vpc_id == "none" ? "${element(compact(concat(list(var.zone_id), aws_route53_zone.this_public.*.id)), 0)}" : "${element(compact(concat(list(var.zone_id), aws_route53_zone.this_private.*.id)), 0)}"
}

output "ns_servers" {
  value = var.zone_id == "none" ? ( var.vpc_id == "none" ? aws_route53_zone.this_public.0.name_servers : aws_route53_zone.this_private.0.name_servers) : []
  depends_on = [ aws_route53_zone.this_public, aws_route53_zone.this_private ]
}
