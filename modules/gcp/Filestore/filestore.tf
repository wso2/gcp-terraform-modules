# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "google_filestore_instance" "persistent_storage" {
  name     = join("-", compact([var.filestore_abbreviation, var.filestore_name]))
  tier     = var.filestore_tier
  location = var.filestore_location
  project  = var.project_id
  labels   = var.labels

  file_shares {
    name        = var.share_name
    capacity_gb = var.share_capacity_gb
  }

  networks {
    network      = var.vpc_name
    modes        = var.network_modes
    connect_mode = var.connet_mode
  }
}
