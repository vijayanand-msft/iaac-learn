# Variable file for INT env

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
    region="region1"
    resource_group_name = "rg-st-uksouth-01"
    resource_group_key = "int"
    # Account types are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    account_kind = "BlobStorage"
    # Account Tier options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_tier = "Standard" 
    #  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    account_replication_type = "LRS" # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    min_tls_version          = "TLS1_2"
    // allow_blob_public_access = true
    tags = {
      environment = "dev"
      team        = "IT"
      ##
    }
    /* containers = {
      dev = {
        name = "random"
      }
    }*/
    private_endpoints = {
      stpe = {
        name = "pe-st-uks-01"
        resource_group_name = "rg-st-uksouth-01"
        subnet_id = "snet-st-uks-01"
        private_service_connection ={
          name              = "psc-stg-level0"
          subresource_names = ["blob"]
        }
      }
    } 
    private_dns = {
      zone_group_name = "default"
          # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
         # keys = ["dns1"]
          # ids = []    # List of DNS resource ids
    }
   network={
     default_action="Deny"
      bypass   =["AzureServices"]
       ip_rules = ["82.31.49.178"]
       subnets = {
        subnet1 = {
         
        }
      }
    }

    enable_system_msi = true
  }
}

vnet = {
  subnet_name = "snet-st-uks-01"
  resource_group_name = "rg-vnet-uksouth-01"
  virtual_network_name = "vnet-uksouth-01"
}

storage_account_containers = {
  containers = {
      dev = {
        name = "random"
      }
    }
}