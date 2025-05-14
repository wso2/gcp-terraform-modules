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
  description = "The project name of the NAT gateway"
  type        = string
}
variable "environment" {
  description = "The environment of the NAT gateway"
  type        = string
}
variable "region" {
  description = "The region of the NAT gateway"
  type        = string
}
variable "vpc_name" {
  description = "The VPC name"
  type        = string
}
variable "enable_endpoint_independent_mapping" {
  description = "Enable endpoint independent mapping"
  type        = bool
  default     = false
}
variable "max_ports_per_vm" {
  description = "The maximum number of ports per VM"
  type        = number
  default     = 65536
}
variable "min_ports_per_vm" {
  description = "The minimum number of ports per VM"
  type        = number
  default     = 8192
}
variable "nat_ip_allocate_option" {
  description = "The NAT IP allocation option"
  type        = string
  default     = "AUTO_ONLY"
}
variable "tcp_time_wait_timeout_sec" {
  description = "The TCP time wait timeout in seconds"
  type        = number
  default     = 120
}
