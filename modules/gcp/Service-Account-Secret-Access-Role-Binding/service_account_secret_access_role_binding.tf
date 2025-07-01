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

resource "google_secret_manager_secret_iam_member" "service_account_iam_member" {
  for_each  = toset(var.secret_names)
  project   = var.project_name
  secret_id = each.value
  role      = var.secret_role
  member    = "serviceAccount:${var.service_account_email}"
}
