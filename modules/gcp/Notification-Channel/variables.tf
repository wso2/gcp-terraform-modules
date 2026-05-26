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

variable "channel_abbreviation" {
  description = "Abbreviation prepended to the channel display name via join"
  type        = string
  default     = "nc"
}

variable "channel_name" {
  description = "Name segment of the notification channel display name"
  type        = string
}

variable "project_id" {
  description = "The ID of the project in which the notification channel will be created"
  type        = string
}

variable "channel_type" {
  description = "The type of the notification channel"
  type        = string
  default     = "email"
}

variable "description" {
  description = "Optional human-readable description of the notification channel. Maximum 1024 Unicode characters"
  type        = string
  default     = null
}

variable "enabled" {
  description = "Whether notifications are forwarded to this channel. Setting to false disables delivery without removing the channel from alert policies"
  type        = bool
  default     = true
}

variable "force_delete" {
  description = "If true, the channel is deleted even when still referenced by alert policies (those policies are updated to remove the channel)"
  type        = bool
  default     = false
}

variable "deletion_policy" {
  description = "Policy for handling the notification channel resource when the Terraform resource is destroyed"
  type        = string
  default     = "DELETE"

  validation {
    condition     = contains(["DELETE", "PREVENT", "ABANDON"], var.deletion_policy)
    error_message = "deletion_policy must be one of: DELETE, PREVENT, ABANDON."
  }
}

# ─── Channel Configuration Labels ────────────────────────────────────────────
# These are type-specific configuration fields, NOT organizational tags.
# The required keys vary by channel type. Examples:
#   email              : { email_address = "user@example.com" }
#   slack              : { channel_name  = "#alerts" }
#   pagerduty          : { service_name  = "my-service" }
#   webhook_basicauth  : { url = "https://...", username = "user" }
#   pubsub             : { topic = "projects/PROJECT/topics/TOPIC" }
# Sensitive values (auth tokens, passwords, service keys) must be passed via
# sensitive_labels instead of this map.

variable "labels" {
  description = "Type-specific configuration fields for the notification channel"
  type        = map(string)
  default     = {}
}

variable "user_labels" {
  description = "User-defined key/value pairs for organizing and identifying the channel"
  type        = map(string)
  default     = {}
}

# ─── Sensitive Channel Configuration ─────────────────────────────────────────
# Use this block for credentials that must not appear in plan output.
# Exactly one of each pair may be set (sensitive vs. write-only); write-only
# variants (auth_token_wo, password_wo, service_key_wo) require Terraform >= 1.12
# and are not exposed by this module.
#
#   auth_token  - Slack authorization token
#   password    - webhook_basicauth password
#   service_key - PagerDuty service key

variable "sensitive_labels" {
  description = "Sensitive configuration fields for the notification channel"
  type = object({
    auth_token  = optional(string)
    password    = optional(string)
    service_key = optional(string)
  })
  default   = null
  sensitive = true
}
