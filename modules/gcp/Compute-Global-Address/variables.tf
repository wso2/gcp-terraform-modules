# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

variable "compute_address_abbreviation" {
  description = "The abbreviation for compute address"
  type        = string
  default     = "ip"
}

variable "compute_address_name" {
  description = "The name of the compute address"
  type        = string
}

variable "address" {
  description = "The static IP address to reserve (optional)"
  type        = string
  default     = null
}

variable "address_type" {
  description = "The type of the address (optional)"
  type        = string
  default     = "INTERNAL"
}

variable "description" {
  description = "An optional description of this resource"
  type        = string
  default     = null
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "network" {
  description = "The URL of the network in which to reserve the address (optional)"
  type        = string
  default     = null
}

variable "purpose" {
  description = "The purpose of the address (optional)"
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "prefix_length" {
  description = "The prefix length if the address is a part of a reserved range (optional)"
  type        = number
  default     = null
}
