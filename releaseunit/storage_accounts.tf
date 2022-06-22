module "resource_group" {
  source = "./modules/resource_group"
  for_each = var.storage_accounts
  resource_group_name =each.value.resource_group_name
  settings            = {}
  global_settings     = local.global_settings
  tags                = var.resource_group_tags
}

/* storage account with Private Endpoint*/
module "storage_accounts" {
  depends_on = [module.resource_group]
  source   = "./modules/storage_account"
  for_each = var.storage_accounts
  global_settings   = local.global_settings
  client_config     = local.client_config
  storage_account   = each.value
  vnet              = var.vnet
  private_endpoints = try(each.value.private_endpoints, {})
  location          = local.global_settings.regions[each.value.region]
}

module "storage_account_container" {
  depends_on = [module.storage_accounts]
  source="./modules/storage_account/container"
  for_each = try(var.storage_account_containers.containers, {})

  storage_account_name = module.storage_accounts.sa1.name
  settings             = each.value
}

output "storage_accounts" {
  value     = module.storage_accounts
  sensitive = true
}

output "resource_group" {
  value = module.resource_group
}