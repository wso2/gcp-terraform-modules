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

resource "google_container_node_pool" "node_pool" {
  name           = var.node_pool_name
  project        = var.project_name
  location       = var.node_pool_location
  cluster        = var.cluster_id
  node_count     = var.node_pool_node_count
  node_locations = var.node_pool_zone_locations
  version        = var.master_kubernetes_version

  node_config {
    preemptible     = var.preemptible_nodes
    machine_type    = var.node_pool_machine_type
    service_account = var.cluster_service_account
    image_type      = "COS_CONTAINERD"
    local_ssd_count = 0
    disk_size_gb    = 50
    disk_type       = "pd-balanced"
    metadata = {
      disable-legacy-endpoints = true
    }
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
    oauth_scopes = var.oauth_scopes
    dynamic "taint" {
      for_each = var.taint_settings
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }
    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = false
    }
    labels = var.labels
  }
  management {
    auto_repair  = true
    auto_upgrade = false
  }
  network_config {
    enable_private_nodes = true
    create_pod_range     = false
    pod_range            = "cluster-pods"
  }
  autoscaling {
    max_node_count  = var.node_pool_max_node_count
    min_node_count  = var.node_pool_min_node_count
    location_policy = var.node_location_policy
  }
  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
    strategy        = "SURGE"
  }
}
