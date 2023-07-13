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

variable "project_name" {
  description = "The project name where the alert needs to be added"
  type        = string
}
variable "tier" {
  description = "The redis tier"
  type        = string
}
variable "environment" {
  description = "The redis environment"
  type        = string
}
variable "redis_name" {
  description = "The memorystore redis name"
  type        = string
}
variable "redis_version" {
  description = "The redis version"
  type        = string
}
variable "region" {
  description = "The redis region"
  type        = string
}
variable "zone" {
  description = "The redis zone"
  type        = string
}
variable "vpc_id" {
  description = "The vpc id"
  type        = string
}
variable "labels" {
  description = "The alert alignment period"
  type        = map(string)
}
variable "memory_size_gb" {
  description = "The memory size in GB"
  type        = number
}
variable "reserved_ip_range" {
  description = "The reserved ip range"
  type        = string
}
variable "internal_dns_name" {
  description = "The dev internal dns name"
  type        = string
}
