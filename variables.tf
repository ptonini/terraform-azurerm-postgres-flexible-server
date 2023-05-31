variable "name" {}

variable "rg" {}

variable "storage" {
  type    = number
  default = 5120
}

variable "create_mode" {
  default = "Default"
}

variable "backup_retention_days" {
  type    = number
  default = 30
}

variable "geo_redundant_backup_enabled" {
  type    = bool
  default = false
}

variable "admin_username" {
  type    = string
  default = "postgres"
}

variable "postgres_version" {
  type    = number
  default = 11
}

variable "sku_name" {}

variable "zone" {
  default = 1
}

variable "allowed_sources" {
  default = {}
  type = map(object({
    start_address = string
    end_address   = string
  }))
}

variable "subnet_id" {
  default = null
}

variable "private_dns_zone" {
  default = {
    id   = null
    name = null
  }
  type = object({
    id   = string
    name = string
  })
}