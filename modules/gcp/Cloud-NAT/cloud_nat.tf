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

resource "google_compute_router_nat" "vpc_nat" {
  name                                = join("-", ["nat", var.environment])
  project                             = var.project_name
  router                              = google_compute_router.nat_router.name
  region                              = var.region
  nat_ip_allocate_option              = var.nat_ip_allocate_option
  enable_endpoint_independent_mapping = var.enable_endpoint_independent_mapping
  source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  max_ports_per_vm                    = var.max_ports_per_vm
  min_ports_per_vm                    = var.min_ports_per_vm

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
  depends_on = [
    google_compute_router.nat_router
  ]
}

resource "google_compute_router" "nat_router" {
  name    = join("-", ["nat-router", var.environment])
  project = var.project_name
  region  = var.region
  network = var.vpc_name

  bgp {
    asn = 64514
  }
}
