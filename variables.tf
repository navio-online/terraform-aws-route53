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

variable "tags" {
  type = map
  description = "Tags"
  default = {}
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
