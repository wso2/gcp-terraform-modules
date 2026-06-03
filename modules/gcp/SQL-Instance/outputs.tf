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

output "private_ip_address" {
  depends_on = [google_sql_database_instance.instance]
  value      = google_sql_database_instance.instance.private_ip_address
}

output "connection_name" {
  depends_on = [google_sql_database_instance.instance]
  value      = google_sql_database_instance.instance.connection_name
}
