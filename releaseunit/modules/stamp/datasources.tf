data "azurerm_client_config" "current" {}


data "azurerm_log_analytics_workspace" "stamp" {
  name                = "${local.prefix}-${var.location}-log"
  resource_group_name = azurerm_resource_group.stamp.name
}


data "azurerm_storage_account" "global" {
  name                = var.global_storage_account_name
  resource_group_name = azurerm_resource_group.stamp.name
}