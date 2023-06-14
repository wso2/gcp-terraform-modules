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

variable "project" {
  description = "The project name to host the GAR"
  type        = string
}
variable "zone" {
  description = "The zone of bastion VM"
  type        = string
}
variable "location" {
  description = "The location of the bastion VM"
  type        = string
}
variable "bastion_service_account_email" {
  description = "The bastion service account email"
  type        = string
}
variable "vpc_name" {
  description = "The VPC name"
  type        = string
}
variable "subnetwork_id" {
  description = "The subnetwork name"
  type        = string
}
variable "ssh_public_key_path" {
  description = "The path to the ssh public key"
  type        = string
}
variable "bastion_vm_machine_type" {
  description = "The bastion VM machine type"
  type        = string
  default     = "e2-medium"
}
variable "boot_disk_image" {
  description = "The bastion VM boot disk image"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}
