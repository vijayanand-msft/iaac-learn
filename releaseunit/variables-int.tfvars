# Variable file for INT env
# vnet_address_space = "10.1.0.0/18" # /18 allows for up to 4 stamps

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "uksouth"
  }
}
resource_group_tags={
   environment = "int"
      team        = "IT"
}


 
storage_accounts = {
    
  sa1 = {
    name = "sauksint"
    # This option is to enable remote RG reference
    # resource_group = {
    #   lz_key = ""
    #   key    = ""
    # }
    resource_group_name = "rg-st-uksouth-01"
    resource_group_key = "int"
    # Account types are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    account_kind = "BlobStorage"
    # Account Tier options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_tier = "Standard"
    #  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    account_replication_type = "LRS" # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    tags = {
      environment = "dev"
      team        = "IT"
      ##
    }
       private_dns = {
          zone_group_name = "default"
          # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
         # keys = ["dns1"]
          # ids = []    # List of DNS resource ids
        }
    containers = {
      dev = {
        name = "random"
      }
    }

    enable_system_msi = true
  }
}
