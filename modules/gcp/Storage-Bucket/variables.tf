# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "storage_bucket_name" {
  description = "The name of the storage bucket"
  type        = string
}

variable "location" {
  description = "The location of the storage bucket"
  type        = string
}

variable "storage_class" {
  description = "The storage class of the storage bucket"
  type        = string
}

variable "uniform_bucket_level_access" {
  description = "Whether to enable uniform bucket-level access"
  type        = bool
  default     = true
}

variable "public_access_prevention" {
  description = "Whether to enable public access prevention"
  type        = bool
  default     = false
}

variable "environment" {
  description = "The environment for the storage bucket"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}
