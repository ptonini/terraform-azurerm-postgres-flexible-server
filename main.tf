resource "random_password" "this" {
  length  = 16
  special = false
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                         = var.name
  create_mode                  = var.create_mode
  resource_group_name          = var.rg.name
  location                     = var.rg.location
  version                      = var.postgres_version
  sku_name                     = var.sku_name
  storage_mb                   = var.storage
  administrator_login          = var.admin_username
  administrator_password       = random_password.this.result
  zone                         = var.zone
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  delegated_subnet_id          = var.subnet_id
  private_dns_zone_id          = var.private_dns_zone.id
}

data "azurerm_private_dns_a_record" "this" {
  provider            = azurerm
  count               = var.private_dns_zone == null ? 0 : 1
  name                = azurerm_postgresql_flexible_server.this.name
  zone_name           = var.private_dns_zone.name
  resource_group_name = var.rg.name
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "this" {
  for_each         = var.allowed_sources
  name             = each.key
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = each.value.start_address
  end_ip_address   = coalesce(each.value.end_address, each.value.start_address)
}