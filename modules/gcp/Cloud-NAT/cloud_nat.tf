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

resource "google_compute_router" "router" {
  name        = join("-", compact([var.router_abbreviation, var.router_name]))
  project     = var.project_id
  region      = var.region
  network     = var.vpc_name
  description = var.router_description

  bgp {
    asn = var.router_asn
  }
}

resource "google_compute_router_nat" "router_nat" {
  name                                = join("-", compact([var.nat_abbreviation, var.router_name]))
  project                             = var.project_id
  router                              = google_compute_router.router.name
  region                              = var.region
  nat_ip_allocate_option              = var.nat_ip_allocate_option
  nat_ips                             = var.nat_ips
  enable_endpoint_independent_mapping = var.enable_endpoint_independent_mapping
  source_subnetwork_ip_ranges_to_nat  = var.source_subnetwork_ip_ranges_to_nat
  tcp_time_wait_timeout_sec           = var.tcp_time_wait_timeout_sec
  max_ports_per_vm                    = var.max_ports_per_vm
  min_ports_per_vm                    = var.min_ports_per_vm

  dynamic "subnetwork" {
    for_each = var.source_subnetwork_ip_ranges_to_nat == "LIST_OF_SUBNETWORKS" ? coalesce(var.subnetworks, []) : []
    content {
      name                    = each.value.name
      source_ip_ranges_to_nat = each.value.source_ip_ranges_to_nat
    }
  }

  log_config {
    enable = var.enable_nat_logging
    filter = var.nat_logging_filter
  }
}
