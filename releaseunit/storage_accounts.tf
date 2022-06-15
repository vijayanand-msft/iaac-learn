module "resource_group" {
  source = "./modules/resource_group"
  for_each = var.storage_accounts
  resource_group_name =each.value.resource_group_name
  settings            = {}
  global_settings     = local.global_settings
  tags                = var.resource_group_tags
}

data "azurerm_subnet" "stsubnet" { 
  
  resource_group_name ="rg-vnet-uksouth-01"
  name = "snet-st-uks-01"
  virtual_network_name = "vnet-uksouth-01"

}

module "storage_account_pe" {
  source = "./modules/networking/private_links/endpoints/private_endpoint"
  depends_on = [module.resource_group]
  for_each = var.storage_accounts

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  //resource_id         = can(each.value.resource_id) ? each.value.resource_id : var.remote_objects.storage_accounts[var.client_config.landingzone_key][try(each.value.key, each.key)].id
 
  subresource_names   = toset(try(each.value.private_service_connection.subresource_names, ["blob"]))
  subnet_id           = data.azurerm_subnet.stsubnet.id
  private_dns         = each.value.private_dns
  name                = "pe-st-uksouth-01"
  resource_group_name = each.value.resource_group_name
  location            = "uksouth" # The private endpoint must be deployed in the same region as the virtual network.
  base_tags           = each.value.tags
}

module "storage_accounts" {
  depends_on = [module.resource_group, module.storage_account_pe]
  source   = "./modules/storage_account"
  for_each = var.storage_accounts

  global_settings   = local.global_settings
  client_config     = local.client_config
  storage_account   = each.value
  //vnets             = local.combined_objects_networking
  //private_endpoints = try(each.value.private_endpoints, {})
  //resource_groups   = try(each.value.private_endpoints, {}) == {} ? null : module.resource_groups
  //resource_groups   = var.resource_groups
  //recovery_vaults   = local.combined_objects_recovery_vaults
  //private_dns       = local.combined_objects_private_dns

  location            = "uksouth"
  //base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  //diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  //diagnostics         = local.combined_diagnostics
}

output "storage_accounts" {
  value     = module.storage_accounts
  sensitive = true
}

output "resource_group" {
  value = module.resource_group
}