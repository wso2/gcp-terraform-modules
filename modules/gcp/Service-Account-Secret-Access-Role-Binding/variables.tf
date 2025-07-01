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
variable "secret_role" {
  type        = string
  description = "The secret role"
  default     = "roles/secretmanager.secretAccessor"
}
variable "service_account_email" {
  description = "The service account email"
  type        = string
}
variable "secret_names" {
  description = "The name of the secret"
  type        = list(string)
}
