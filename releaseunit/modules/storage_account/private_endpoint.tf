data "azurerm_subnet" "stsubnet" { 
  
  resource_group_name =var.vnet.resource_group_name
  name = var.vnet.subnet_name
  virtual_network_name = var.vnet.virtual_network_name

}

module "private_endpoint" {
  source   = "../networking/private_endpoint"
  for_each = var.private_endpoints

  resource_id         = azurerm_storage_account.stg.id
  name                = each.value.name
  location            = azurerm_storage_account.stg.location
  resource_group_name = azurerm_storage_account.stg.resource_group_name
  subnet_id           = data.azurerm_subnet.stsubnet.id
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = local.tags
  private_dns         = var.private_dns
  client_config       = var.client_config
}


