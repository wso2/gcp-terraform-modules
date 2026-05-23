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

output "gke_node_pool_id" {
  value      = google_container_node_pool.node_pool.id
  depends_on = [google_container_node_pool.node_pool]
}

output "gke_node_pool_name" {
  value      = google_container_node_pool.node_pool.name
  depends_on = [google_container_node_pool.node_pool]
}

output "gke_node_pool_instance_group_urls" {
  value      = google_container_node_pool.node_pool.instance_group_urls
  depends_on = [google_container_node_pool.node_pool]
}

output "gke_node_pool_managed_instance_group_urls" {
  value      = google_container_node_pool.node_pool.managed_instance_group_urls
  depends_on = [google_container_node_pool.node_pool]
}
