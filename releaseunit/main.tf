terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.8.0"
    }
  }

  backend "azurerm" {
        storage_account_name    = "csb100320018f6e35d3"
        resource_group_name     = "cloud-shell-storage-westeurope"
        container_name          = "tfstate" 
        key                     = "testautomation.terraform.tfstate"
        access_key              = "4qtwI5v1nb2EcC9Qds1SKJNgNtNBcu+WBoGPTPvyqIRFbFhXFlomPD+hCO1ByVV9bSoNVV2CLe5D+AStnD34Mw=="
  }
}

provider "azurerm" {
  features {
    resource_group {
      # Allows the deletion of non-empty resource groups
      # This is required to delete rgs with stale resources left
      prevent_deletion_if_contains_resources = false
    }
  }
}

data "azurerm_client_config" "current" {}
 

 

