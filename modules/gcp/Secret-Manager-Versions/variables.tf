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

variable "project_name" {
  description = "The name of the project"
  type        = string
}
variable "secret_versions" {
  type = list(object({
    secret_name = string
    secret_data = string
  }))
}
variable "existing_secret_ids" {
  type = map(string)
}
variable "labels" {
  description = "The labels"
  type        = map(string)
}
