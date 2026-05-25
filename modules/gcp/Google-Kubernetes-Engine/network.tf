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
# Ignore: AVD-GCP-0029(https://avd.aquasec.com/misconfig/avd-gcp-0029)
# Reason: Flow log enabling is optional due to high cost.

# trivy:ignore:AVD-GCP-0029
resource "google_compute_subnetwork" "cluster_subnetwork" {
  name                     = join("-", compact([var.subnetwork_abbreviation, var.subnetwork_name]))
  network                  = var.vpc_id
  ip_cidr_range            = var.cluster_subnetwork_primary_cidr
  project                  = var.project_id
  region                   = var.location
  private_ip_google_access = var.private_ip_google_access
  description              = "Subnetwork for GKE cluster in ${var.project_id} ${var.location}"

  secondary_ip_range {
    range_name    = "cluster-pods"
    ip_cidr_range = var.cluster_secondary_pods_cidr_range
  }

  secondary_ip_range {
    range_name    = "cluster-services"
    ip_cidr_range = var.cluster_secondary_services_cidr_range
  }

  dynamic "log_config" {
    for_each = var.enable_flow_logs ? [1] : []
    content {
      aggregation_interval = var.aggregation_interval
      flow_sampling        = var.flow_sampling
      metadata             = var.metadata
    }
  }
}
