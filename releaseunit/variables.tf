variable "global_settings" {
  description = "Global settings object for the current deployment."
  default = {
    passthrough    = false
    random_length  = 4
    default_region = "region1"
    regions = {
      region1 = "uksouth"
      //region2 = "eastasia"
    }
  }
}

variable "tags" {
  description = "Tags to be used for this resource deployment."
  type        = map(any)
  default     = null
}


variable "resource_group_tags" {
  default     = {}
  description = "resourcegroup"
}
variable "resource_groups" {
  description = "Configuration object - Resource groups."
  default     = {}
}
## Storage variables
variable "storage_accounts" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "storage" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "diagnostic_storage_accounts" {
  description = "Configuration object - Storage account for diagnostics resources"
  default     = {}
}

variable "random_strings" {
  description = "Configuration object - Random string generator resources"
  default     = {}
}

variable "client_config" {
  default = {}
}

variable "current_landingzone_key" {
  description = "Key for the current landing zones where the deployment is executed. Used in the context of landing zone deployment."
  default     = "local"
  type        = string
}

variable "location" {
  type        = string
  default     = "uksouth"
  description = "default resources location"
}


variable "global_storage_account_name" {
  type        = string
  description = "storage account name"
  default = "sttfuks01"
}

########### Common variables (same for global resources and for release units) ###########



#variable "stamps" {
 # description = "List of Azure regions into which stamps are deployed. Important: The main location (var.location) MUST be included as the first item in this list."
 # type        = list(string)
#}

variable "branch" {
  description = "Name of the repository branch used for the deployment. Used as an Azure Resource Tag."
  type        = string
  default     = "not set"
}

variable "queued_by" {
  description = "Name of the user who has queued the pipeline run that has deployed this environment. Used as an Azure Resource Tag."
  type        = string
  default     = "n/a"
}

variable "environment" {
  description = "Environment - int, prod or e2e"
  type        = string
  default     = "int"
}

variable "contact_email" {
  description = "Email address for alert notifications"
  type        = string
  default     = " "
}

variable "alerts_enabled" {
  description = "Enable alerts?"
  type        = bool
  default     = false
}

########### Release Unit specific variables ###########

variable "vnet_address_space" {
  description = "Address space used for the VNets. Must be large enough to provide at least of size /20 per stamp!"
  type        = string
  default = ""
}

variable "vnet" {
  default = {}
}

variable "storage_account_containers" {
  default = {}
}