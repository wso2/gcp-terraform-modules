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
  type        = string
  description = "The name of the project where the service account is located"
}
variable "service_account_email" {
  type        = string
  description = "The email of the service account to which the IAM roles will be assigned"
}
variable "roles" {
  type        = list(string)
  description = "A list of IAM roles to assign to the service account"
}
