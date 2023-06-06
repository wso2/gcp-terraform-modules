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

# GCP setup variables
variable "project" {
  description = "The project name"
  type        = string
}
variable "environment" {
  description = "The environment name"
  type        = string
}
variable "cluster_location" {
  description = "The location name"
  type        = string
}
variable "gke_cluster_version" {
  description = "The gke cluster version"
  type        = string
}
variable "vpc_id" {
  description = "The vpc id"
  type        = string
}
variable "cluster_ipv4_cidr" {
  description = "The cluster ipv4 cidr"
  type        = string
}
variable "node_pool_name" {
  description = "The node pool name"
  type        = string
}
variable "node_pool_location" {
  description = "The node pool location"
  type        = string
}
variable "node_pool_zone_locations" {
  description = "The node pool node zone locations"
  type        = list(string)
}
variable "node_pool_node_count" {
  description = "The node pool node count"
  type        = number
}
variable "node_pool_machine_type" {
  description = "The node pool machine type"
  type        = string
}
variable "node_pool_min_node_count" {
  description = "The node pool min node count"
  type        = number
}
variable "node_pool_max_node_count" {
  description = "The node pool max node count"
  type        = number
}
variable "default_max_pods_per_node" {
  description = "The default max pods per node"
  type        = number
}
variable "master_cluster_ipv4_cidr" {
  description = "The master cluster ipv4 cidr"
  type        = string
}
variable "master_authorized_networks_cidr" {
  description = "The master authorized networks cidr"
  type        = string
}
variable "labels" {
  description = "The labels"
  type        = map(string)
}
