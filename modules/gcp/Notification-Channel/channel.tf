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

resource "google_monitoring_notification_channel" "channel" {
  project         = var.project_id
  display_name    = join("-", compact([var.channel_abbreviation, var.channel_name]))
  description     = var.description
  type            = var.channel_type
  labels          = var.labels
  user_labels     = var.user_labels
  enabled         = var.enabled
  force_delete    = var.force_delete
  deletion_policy = var.deletion_policy

  dynamic "sensitive_labels" {
    for_each = var.sensitive_labels != null ? [var.sensitive_labels] : []
    content {
      auth_token  = sensitive_labels.value.auth_token
      password    = sensitive_labels.value.password
      service_key = sensitive_labels.value.service_key
    }
  }
}
