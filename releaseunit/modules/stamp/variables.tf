variable "location" {
  description = "Azure Region for this stamp"
  type        = string
}

variable "prefix" {
  description = "Resource Prefix"
  type        = string
  default = "sample"
}

variable "queued_by" {
  description = "Name of the user who has queued the pipeline run that has deployed this environment. Used as an Azure Resource Tag."
  type        = string
  default     = "n/a"
}

variable "default_tags" {}

variable "global_storage_account_name" {
  description = "Name of the globally shared storage account, which is used for image storage"
  type        = string
}