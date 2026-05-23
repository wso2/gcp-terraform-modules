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
  name           = join("-", compact([var.node_pool_abbreviation, var.node_pool_name]))
  project        = var.project_id
  location       = var.node_pool_location
  cluster        = var.cluster_id
  node_count     = var.node_pool_node_count
  node_locations = var.node_pool_zone_locations
  version        = var.kubernetes_version

  node_config {
    preemptible     = var.preemptible_nodes
    machine_type    = var.node_pool_machine_type
    service_account = var.cluster_service_account
    image_type      = "COS_CONTAINERD"
    local_ssd_count = var.local_ssd_count
    disk_size_gb    = var.disk_size_gb
    disk_type       = var.disk_type
    oauth_scopes    = var.oauth_scopes
    labels          = var.labels
    tags            = var.tags

    metadata = {
      disable-legacy-endpoints = true
    }

    workload_metadata_config {
      mode = var.workload_metadata_mode
    }

    dynamic "taint" {
      for_each = var.taint_settings
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }

    shielded_instance_config {
      enable_integrity_monitoring = var.enable_integrity_monitoring
      enable_secure_boot          = var.enable_secure_boot
    }
  }

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
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
    max_surge       = var.upgrade_max_surge
    max_unavailable = var.upgrade_max_unavailable
    strategy        = var.upgrade_strategy
  }

  lifecycle {
    create_before_destroy = true
  }
}
