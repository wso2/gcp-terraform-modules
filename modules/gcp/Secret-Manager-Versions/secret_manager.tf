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

resource "google_secret_manager_secret_version" "secret_version" {
  for_each    = { for sv in var.secret_versions : sv.secret_name => sv }
  secret      = var.existing_secret_ids[each.value.secret_name]
  secret_data = each.value.secret_data
}
