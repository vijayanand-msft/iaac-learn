output "location" {
  value = var.location
}

output "resource_group_name" {
  value = azurerm_resource_group.stamp.name
}


# Name of the public Storage Account
output "public_storage_account_name" {
  value = azurerm_storage_account.public.name
}
