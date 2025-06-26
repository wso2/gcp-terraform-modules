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

output "memorystore_redis_instance_id" {
  value = google_redis_instance.memorystore_redis_instance.id
  depends_on = [
    google_redis_instance.memorystore_redis_instance
  ]
}
output "memorystore_redis_instance_name" {
  value = google_redis_instance.memorystore_redis_instance.name
  depends_on = [
    google_redis_instance.memorystore_redis_instance
  ]
}
output "memorystore_redis_instance_host" {
  value = google_redis_instance.memorystore_redis_instance.host
  depends_on = [
    google_redis_instance.memorystore_redis_instance
  ]
}
output "memorystore_redis_instance_port" {
  value = google_redis_instance.memorystore_redis_instance.port
  depends_on = [
    google_redis_instance.memorystore_redis_instance
  ]
}
output "memorystore_redis_instance_auth_string" {
  value = google_redis_instance.memorystore_redis_instance.auth_string
  depends_on = [
    google_redis_instance.memorystore_redis_instance
  ]
}

output "memorystore_redis_instance_ca_cert" {
  value = google_redis_instance.memorystore_redis_instance.server_ca_certs[0].cert
  depends_on = [
    google_redis_instance.memorystore_redis_instance
  ]
}
