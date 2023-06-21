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

resource "google_compute_subnetwork" "cluster_subnetwork" {
  name                     = join("-", ["snet", "gke-cluster", var.environment])
  project                  = var.project
  ip_cidr_range            = var.cluster_primary_subnet_cidr_range
  region                   = var.cluster_location
  network                  = var.vpc_id
  private_ip_google_access = true
  secondary_ip_range {
    range_name    = "cluster-pods"
    ip_cidr_range = var.cluster_secondary_pods_cidr_range
  }
  secondary_ip_range {
    range_name    = "cluster-services"
    ip_cidr_range = var.cluster_secondary_services_cidr_range
  }
}
