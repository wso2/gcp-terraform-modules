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
  description = "ID of the GCP project where the filestore instance will be created."
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "filestore_tier" {
  description = "Filestore tier (e.g., STANDARD, PREMIUM, BASIC_HDD, BASIC_SSD)"
  type        = string
}

variable "share_capacity_gb" {
  description = "Filestore share capacity in GB"
  type        = number
}

variable "filestore_location" {
  description = "Filestore location"
  type        = string
}

variable "filestore_name" {
  description = "Name of the filestore instance"
  type        = string
}

variable "filestore_abbreviation" {
  description = "Abbreviation for the filestore"
  type        = string
  default     = "filestore"
}

variable "share_name" {
  description = "Name of the filestore share"
  type        = string
}

variable "network_modes" {
  description = "Network modes for the filestore instance (e.g., MODE_IPV4, MODE_IPV6)"
  type        = list(string)
  default     = ["MODE_IPV4"]
}

variable "connet_mode" {
  description = "Connect mode for the filestore instance (e.g., DIRECT_PEERING, PRIVATE_SERVICE_ACCESS)"
  type        = string
  default     = "DIRECT_PEERING"
}

variable "labels" {
  description = "Labels to apply to the filestore instance"
  type        = map(string)
  default     = {}
}
