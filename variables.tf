variable "description" {
  description = "Description of the DNS Zone"
  default     = ""
}

variable "domain" {
  description = "DNS domain zone"
}

variable "zone_id" {
  description = "Imported Zone ID when Available"
  default     = "none"
}

variable "vpc_id" {
  description = "VPC for private zone"
  default     = "none"
}

variable "records" {
  description = "List of DNS Records to add to the DNS zone"
  type = object({
    names = list(string)
    types = list(string)
    ttls = list(string)
    values = list(string)
  })
  default = {
    names  = []
    types  = []
    ttls   = []
    values = []
  }
}

# locals {
#   default_records = {
#     names  = []
#     types  = []
#     ttls   = []
#     values = []
#   }
#   # merged_records = local.default_records
#   merged_records = merge(local.default_records, var.records)
# }

variable "aliases" {
  description = "List of DNS aliaseses to add to the DNS zone"
  type = object({
    names = list(string)
    types = list(string)
    zones_id = list(string)
  })
  default = {
    names = []
    types = []
    zones_id = []
  }
}

# locals {
#   default_aliases = {
#     names = []
#     values = []
#     zones_id = []
#   }
#   merged_aliases = local.default_aliases
#   # merged_aliases = merge(local.default_aliases, var.aliases)
# }
