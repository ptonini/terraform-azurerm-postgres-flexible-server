output "this" {
  value = azurerm_postgresql_flexible_server.this
}

output "credentials" {
  value = {
    port     = 5432
    host     = var.private_dns_hostname == null ? azurerm_postgresql_flexible_server.this.fqdn : tolist(data.azurerm_private_dns_a_record.this[0].records)[0]
    username = var.admin_username
    password = random_password.this.result
  }
}