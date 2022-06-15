# This "public" storage account is being used for the static website hosting
resource "azurerm_storage_account" "public" {
  name                     = "${local.prefix}${local.location_short}pubst"
  resource_group_name      = azurerm_resource_group.stamp.name
  location                 = azurerm_resource_group.stamp.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  min_tls_version          = "TLS1_2"

  # Enable static website hosting. We will use that to host our UI app
  static_website {
    index_document = "index.html"
  }

  tags = var.default_tags
}


####################################### PUBLIC STORAGE DIAGNOSTIC SETTINGS #######################################

# Use this data source to fetch all available log and metrics categories. We then enable all of them
data "azurerm_monitor_diagnostic_categories" "storage_public" {
  resource_id = azurerm_storage_account.public.id
}

resource "azurerm_monitor_diagnostic_setting" "storage_public" {
  name                       = "storageladiagnostics"
  target_resource_id         = azurerm_storage_account.public.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.stamp.id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_public.logs

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_public.metrics

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }
}

data "azurerm_monitor_diagnostic_categories" "storage_public_blob" {
  resource_id = "${azurerm_storage_account.public.id}/blobServices/default/"
}

resource "azurerm_monitor_diagnostic_setting" "storage_public_blob" {
  name                       = "storageblobladiagnostics"
  target_resource_id         = "${azurerm_storage_account.public.id}/blobServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.stamp.id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_public_blob.logs

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_public_blob.metrics

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }
}

####################################### PRIVATE STORAGE DIAGNOSTIC SETTINGS #######################################

# Use this data source to fetch all available log and metrics categories. We then enable all of them
data "azurerm_monitor_diagnostic_categories" "storage_private" {
  resource_id = azurerm_storage_account.private.id
}

resource "azurerm_monitor_diagnostic_setting" "storage_private" {
  name                       = "storageladiagnostics"
  target_resource_id         = azurerm_storage_account.private.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.stamp.id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_private.logs

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_private.metrics

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }
}

data "azurerm_monitor_diagnostic_categories" "storage_private_blob" {
  resource_id = "${azurerm_storage_account.private.id}/blobServices/default/"
}

resource "azurerm_monitor_diagnostic_setting" "storage_private_blob" {
  name                       = "storageblobladiagnostics"
  target_resource_id         = "${azurerm_storage_account.private.id}/blobServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.stamp.id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_private_blob.logs

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_private_blob.metrics

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }
}