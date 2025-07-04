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

variable "length" {
  description = "The length of the password to generate."
  type        = number
  default     = 16
}
variable "upper" {
  description = "If true, the password will include uppercase characters."
  type        = bool
  default     = true
}
variable "lower" {
  description = "If true, the password will include lowercase characters."
  type        = bool
  default     = true
}
variable "numeric" {
  description = "If true, the password will include numeric characters."
  type        = bool
  default     = true
}
variable "special" {
  description = "If true, the password will include special characters."
  type        = bool
  default     = true
}
variable "override_special" {
  description = "A string of special characters to override the default set."
  type        = string
  default     = "!@#$%&*()-_=+[]{}<>:?"
}
variable "keepers" {
  description = "A map of arbitrary strings that, when changed, will force the password to be regenerated. Useful for linking the password's lifecycle to another resource."
  type        = map(string)
  default     = {}
}
