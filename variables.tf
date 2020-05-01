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
  type = list(object({
      name   = string
      type   = string
      ttl    = string
      values = list(string)
    }))
  default = []
}

variable "aliases" {
  description = "List of DNS aliaseses to add to the DNS zone"
  type = list(object({
      name    = string
      zone_id = string
      value   = string
    }))
  default = []
}
