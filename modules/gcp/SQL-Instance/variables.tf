# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "region" {
  description = "The region where the database instance will be created"
  type        = string
}

variable "database_version" {
  description = "The MySQL, PostgreSQL or SQL Server version to use"
  type        = string
  default     = "MYSQL_8_0"
}

variable "deletion_protection" {
  default     = true
  description = "Deletion protection. If false, database will be deleted with terraform destroy"
  type        = bool
}

variable "database_tier" {
  description = "The machine type to use. This is the same as the tier field in the settings. See https://cloud.google.com/sql/docs/mysql/instance-settings#machine-type for more details"
  type        = string
}

variable "user_labels" {
  description = "User-defined labels"
  type        = map(string)
  default     = {}
}

variable "availability_type" {
  description = "Availability type of the database instance. Supported values are: ZONAL and REGIONAL"
  type        = string
  default     = "ZONAL"
}

variable "disk_size" {
  description = "The size of data disk in GB"
  type        = number
}

variable "disk_type" {
  description = "The type of data disk"
  type        = string
  default     = "PD_SSD"
}

variable "ipv4_enabled" {
  description = "Whether this Cloud SQL instance should be assigned a public IPV4 address"
  type        = bool
}

variable "query_insights_enabled" {
  description = "Whether Query Insights is enabled for this instance"
  type        = bool
  default     = true
}

variable "username" {
  description = "Username for the database user"
  type        = string
}

variable "password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true
}

variable "backup_enabled" {
  description = "Backup enabled for DB"
  type        = bool
}

variable "binary_log_enabled" {
  description = "Binary logs enabled for DB. This should be true only for MySQL Regional (not Zonal) deployments"
  type        = bool
}

variable "retained_backups" {
  description = "The number of backups to retain"
  type        = number
}

variable "compute_address_abbreviation" {
  description = "The abbreviation for compute address"
  type        = string
  default     = "ip"
}

variable "compute_address_name" {
  description = "The name of the compute address"
  type        = string
}

variable "address" {
  description = "The static IP address to reserve (optional)"
  type        = string
  default     = null
}

variable "purpose" {
  description = "The purpose of the address (optional)"
  type        = string
  default     = "VPC_PEERING"
}

variable "address_type" {
  description = "The type of the address (optional)"
  type        = string
  default     = "INTERNAL"
}

variable "description" {
  description = "An optional description of this resource"
  type        = string
  default     = null
}

variable "prefix_length" {
  description = "The prefix length if the address is a part of a reserved range (optional)"
  type        = number
  default     = 24
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "network" {
  description = "The URL of the network in which to reserve the address (optional)"
  type        = string
}

variable "network_name" {
  description = "The name of the network in which to reserve the address (optional)"
  type        = string
}

variable "database_abbreviation" {
  description = "The abbreviation for database"
  type        = string
  default     = "sql"
}

variable "database_instance_name" {
  description = "The name of the database instance"
  type        = string
}

variable "root_password" {
  description = "The password for the default 'root' user. Must be 8 characters or longer."
  type        = string
  sensitive   = true
}

variable "root_password_wo" {
  description = "The password for the default 'root' user without special characters. Must be 8 characters or longer."
  type        = string
  sensitive   = true
  default     = null
}

variable "root_password_wo_version" {
  description = "The version of the password for the default 'root' user without special characters. Must be 8 characters or longer."
  type        = string
  default     = "1"
}

variable "disk_autoresize" {
  description = "Enables auto-resizing of the storage size"
  type        = bool
  default     = true
}

variable "ssl_mode" {
  description = "The SSL mode to use"
  type        = string
  default     = "ENCRYPTED_ONLY"
}

variable "authorized_networks" {
  description = "The list of external networks that are allowed to connect to the instance (optional)"
  type = list(object({
    name            = optional(string)
    value           = string
    expiration_time = optional(string)
  }))
  default = []
}

variable "transaction_log_retention_days" {
  description = "The number of days to retain transaction logs for point-in-time recovery. This should be set to a value between 1 and 7 when binary log is enabled"
  type        = number
  default     = 7
}

variable "backup_retention_settings_enabled" {
  description = "Whether to enable backup retention settings"
  type        = bool
  default     = true
}

variable "retention_unit" {
  description = "The unit for backup retention settings"
  type        = string
  default     = "COUNT"
}

variable "backup_configuration_enabled" {
  description = "Whether to enable backup configuration"
  type        = bool
  default     = true
}

variable "insights_config_enabled" {
  description = "Whether to enable insights config"
  type        = bool
  default     = true
}

variable "query_string_length" {
  description = "The length of query string to be stored in Query Insights. This should be set to a value between 256 and 4500"
  type        = number
  default     = 1024
}

variable "record_application_tags" {
  description = "Whether to record application tags in Query Insights"
  type        = bool
  default     = false
}

variable "record_client_address" {
  description = "Whether to record client address in Query Insights"
  type        = bool
  default     = false
}

variable "maintenance_window_enabled" {
  description = "Whether to enable maintenance window"
  type        = bool
  default     = true
}

variable "maintenance_window_day" {
  description = "The day of the week for the maintenance window"
  type        = string
  default     = "7"
}

variable "maintenance_window_hour" {
  description = "The hour of the day for the maintenance window"
  type        = number
  default     = 4
}

variable "maintenance_window_update_track" {
  description = "The update track for the maintenance window"
  type        = string
  default     = "stable"
}

variable "password_wo" {
  description = "The password for the database user without special characters"
  type        = string
  sensitive   = true
  default     = null
}

variable "password_wo_version" {
  description = "The version of the password without special characters for the database user"
  type        = string
  default     = "1"
}

variable "user_type" {
  description = "The type of the database user. Supported values are: CLOUD_IAM_USER and BUILT_IN"
  type        = string
  default     = "BUILT_IN"
}

variable "database_flags" {
  description = "The database flags to set on the instance (optional)"
  type        = map(string)
  default     = {}
}
