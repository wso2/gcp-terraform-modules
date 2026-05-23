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

variable "vpc_name" {
  description = "Name of the VPC to be created"
  type        = string
}

variable "project_id" {
  description = "The project ID where the VPC will be created"
  type        = string
}

variable "vpc_abbreviation" {
  description = "Abbreviation for the VPC name, used in resource naming"
  type        = string
  default     = "vpc"
}

variable "description" {
  description = "Description for the VPC"
  type        = string
}

variable "mtu" {
  description = "The MTU size for the VPC network"
  type        = number
  default     = 1460
}

variable "auto_create_subnetworks" {
  description = "Whether to automatically create subnetworks in each region"
  type        = bool
  default     = false
}

variable "routing_mode" {
  description = "The network routing mode to use. Can be either 'REGIONAL' or 'GLOBAL'"
  type        = string
  default     = "REGIONAL"
}
