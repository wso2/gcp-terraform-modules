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
  description = "The project name"
  type        = string
}
variable "project_region" {
  description = "The project region"
  type        = string
}
variable "ip_name" {
  description = "The IP name"
  type        = string
}
variable "network_tier" {
  description = "The network tier"
  type        = string
}
variable "environment" {
  description = "The environment name"
  type        = string
}
