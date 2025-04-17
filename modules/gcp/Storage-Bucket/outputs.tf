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
output "bucket_name" {
  value      = google_storage_bucket.storage_bucket.name
  depends_on = [google_storage_bucket.storage_bucket]
}
output "bucket_url" {
  value      = google_storage_bucket.storage_bucket.url
  depends_on = [google_storage_bucket.storage_bucket]
}
