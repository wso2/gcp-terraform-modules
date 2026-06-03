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
  description = "The project ID where the NAT gateway will be created"
  type        = string
}

variable "region" {
  description = "The region of the NAT gateway"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC network where the NAT gateway will be created"
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

variable "router_abbreviation" {
  description = "The abbreviation for the router name"
  type        = string
  default     = "nat-router"
}

variable "router_name" {
  description = "The name of the router"
  type        = string
}

variable "router_description" {
  description = "The description of the router"
  type        = string
  default     = "Router for Cloud NAT"
}

variable "router_asn" {
  description = "The ASN for the router"
  type        = number
  default     = 64514
}

variable "nat_abbreviation" {
  description = "The abbreviation for the NAT name"
  type        = string
  default     = "nat"
}

variable "nat_ips" {
  description = "The list of NAT IPs to be used for the NAT gateway"
  type        = list(string)
  default     = []
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "The source subnetwork IP ranges to be NATed"
  type        = string
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "enable_nat_logging" {
  description = "Enable logging for the NAT gateway"
  type        = bool
  default     = true
}

variable "nat_logging_filter" {
  description = "The filter for NAT logging"
  type        = string
  default     = "ERRORS_ONLY"
}

variable "subnetworks" {
  description = "The list of subnetworks to be used for the NAT gateway"
  type = list(object({
    name                    = string
    source_ip_ranges_to_nat = list(string)
  }))
  default = []
}

variable "router_nat_name" {
  description = "The name of the router NAT"
  type        = string
}
