output "this" {
  value = azurerm_postgresql_flexible_server.this
}

output "credentials" {
  value = {
    port = 5432
    host = azurerm_postgresql_flexible_server.this.fqdn
    username = var.admin_username
    password = random_password.this.result
  }
}