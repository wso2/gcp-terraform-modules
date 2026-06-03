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

variable "project_id" {
  description = "The project ID where the firewall rule will be created"
  type        = string
}

variable "rule_name" {
  description = "The name of the firewall rule"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the firewall rule will be created"
  type        = string
}

variable "allow_rules" {
  description = "The allow rules"
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  default = []
}

variable "deny_rules" {
  description = "The deny rules"
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  default = []
}

variable "priority" {
  description = "The priority of the rule"
  type        = number
}

variable "direction" {
  description = "The direction of the rule"
  type        = string
  default     = "INGRESS"
}

variable "source_ranges" {
  description = "The source ranges"
  type        = list(string)
  default     = []
}

variable "destination_ranges" {
  description = "The destination ranges"
  type        = list(string)
  default     = []
}

variable "firewall_abbreviation" {
  description = "The abbreviation to be used in the firewall rule name"
  type        = string
  default     = "fwr"
}

variable "disabled" {
  description = "Whether the firewall rule is disabled"
  type        = bool
  default     = false
}

variable "description" {
  description = "The description of the firewall rule"
  type        = string
  default     = null
}
