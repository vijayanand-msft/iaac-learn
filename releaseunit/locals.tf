locals {

  default_tags = {
    Owner       = "Vijay"
    Project     = "Azure IaC Vijay Sample"
    Toolkit     = "Terraform"
    Contact     = var.contact_email
    Environment = var.environment
   // Prefix      = var.prefix
    Branch      = var.branch
  }

  //prefix = lower(var.prefix)



 storage = {
    netapp_accounts        = try(var.storage.netapp_accounts, {})
    storage_account_blobs  = try(var.storage.storage_account_blobs, {})
    storage_account_queues = try(var.storage.storage_account_queues, {})
    storage_containers     = try(var.storage.storage_containers, {})
  }

  
  global_settings = merge({
    default_region     = try(var.global_settings.default_region, "region1")
    environment        = try(var.global_settings.environment, var.environment)
    inherit_tags       = try(var.global_settings.inherit_tags, false)
    passthrough        = try(var.global_settings.passthrough, false)
    prefix             = try(var.global_settings.prefix, null)
   // prefix_with_hyphen = try(var.global_settings.prefix_with_hyphen, format("%s-", try(var.global_settings.prefix, try(var.global_settings.prefixes[0], random_string.prefix.0.result))))
  //  prefixes           = try(var.global_settings.prefix, null) == "" ? null : try([var.global_settings.prefix], try(var.global_settings.prefixes, [random_string.prefix.0.result]))
    random_length      = try(var.global_settings.random_length, 0)
    regions            = try(var.global_settings.regions, null)
    tags               = try(var.global_settings.tags, null)
    use_slug           = try(var.global_settings.use_slug, true)
  }, var.global_settings)

   client_config = var.client_config == {} ? {
    client_id               = data.azurerm_client_config.current.client_id
    landingzone_key         = var.current_landingzone_key
    //logged_aad_app_objectId = local.object_id
    //logged_user_objectId    = local.object_id
    //object_id               = local.object_id
    subscription_id         = data.azurerm_client_config.current.subscription_id
    tenant_id               = data.azurerm_client_config.current.tenant_id
  } : map(var.client_config)
}