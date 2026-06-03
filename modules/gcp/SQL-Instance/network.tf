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

# Database VPC/subnet configurations
# https://cloud.google.com/sql/docs/mysql/configure-private-services-access

resource "google_compute_global_address" "ip_address" {
  name          = join("-", compact([var.compute_address_abbreviation, var.compute_address_name]))
  address       = var.address
  address_type  = var.address_type
  prefix_length = var.prefix_length
  description   = var.description
  project       = var.project_id
  network       = var.network
  purpose       = var.purpose
}

resource "google_service_networking_connection" "network_connection" {
  network                 = var.network_name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.ip_address.name]
}
