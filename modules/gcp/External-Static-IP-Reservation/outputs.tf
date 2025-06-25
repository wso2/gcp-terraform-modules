# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "id" {
  value      = google_compute_address.ip_address.id
  depends_on = [google_compute_address.ip_address]
}

output "ip" {
  value      = google_compute_address.ip_address.address
  depends_on = [google_compute_address.ip_address]
}
