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
  description = "The project name to host the Bastion Instance"
  type        = string
}
variable "zone" {
  description = "The zone of Bastion VM"
  type        = string
}
variable "location" {
  description = "The location to host the Bastion Instance"
  type        = string
}
variable "environment" {
  description = "The environment of the VPC network"
  type        = string
}
variable "vpc_name" {
  description = "The VPC name"
  type        = string
}
variable "bastion_ip_cidr_range" {
  description = "The IP CIDR range of the bastion subnet"
  type        = string
}
<<<<<<< Updated upstream
variable "ssh_public_key_path" {
  description = "The path to the ssh public key"
  type        = string
}
variable "bastion_vm_machine_type" {
  description = "The bastion VM machine type"
=======
variable  "ssh_public_key_path" {
  description = "The directory path to ssh public key"
  type        = string
}
variable "bastion_vm_machine_type" {
  description = "The Bastion VM machine type"
>>>>>>> Stashed changes
  type        = string
  default     = "e2-medium"
}
variable "boot_disk_image" {
<<<<<<< Updated upstream
  description = "The bastion vm boot disk image"
=======
  description = "The Bastion VM boot disk image"
>>>>>>> Stashed changes
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}
