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
  description = "The project name of the GKE cluster"
  type        = string
}
variable "node_pool_location" {
  description = "The node pool location"
  type        = string
}
variable "preemptible_nodes" {
  description = "Whether the node pool is preemptible"
  type        = bool
  default     = false
}
variable "node_pool_zone_locations" {
  description = "The node pool node zone locations"
  type        = list(string)
}
variable "node_pool_node_count" {
  description = "The node pool node count"
  type        = number
}
variable "node_location_policy" {
  description = "The node location policy"
  type        = string
  default     = "BALANCED"
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
variable "master_kubernetes_version" {
  description = "The master Kubernetes version"
  type        = string
}
variable "labels" {
  description = "The labels for the cluster"
  type        = map(string)
}
variable "oauth_scopes" {
  description = "List of oauth scopes to assign"
  type        = list(string)
  default = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email"
  ]
}
variable "taint_settings" {
  description = "Map containing taint settings"
  type = map(object({
    key    = string
    value  = string
    effect = string
  }))
}
variable "node_pool_name" {
  description = "The node pool name"
  type        = string
}
variable "cluster_id" {
  description = "The cluster id"
  type        = string
}
variable "cluster_service_account" {
  description = "The cluster id"
  type        = string
}
variable "disk_size_gb" {
  description = "The disk size in GB"
  type        = number
  default     = 50
}
variable "local_ssd_count" {
  description = "The number of local SSDs to attach to each node"
  type        = number
  default     = 0
}
variable "disk_type" {
  description = "The disk type"
  type        = string
  default     = "pd-balanced"
}
variable "update_stratergy" {
  description = "The update strategy for the node pool"
  type        = string
  default     = "SURGE"
}
variable "upgrade_max_surge" {
  description = "The maximum number of nodes that can be created above the desired number of nodes during an upgrade"
  type        = number
  default     = 1
}
variable "upgrade_max_unavailable" {
  description = "The maximum number of nodes that can be unavailable during an upgrade"
  type        = number
  default     = 0
}
variable "upgate_stratergy" {
  description = "The upgrade strategy for the node pool"
  type        = string
  default     = "SURGE"
}
