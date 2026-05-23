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

resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = join("-", compact([var.service_account_abbreviation, var.service_account_name]))
  display_name = join("-", compact([var.service_account_abbreviation, var.service_account_name]))
  description  = var.description
}
