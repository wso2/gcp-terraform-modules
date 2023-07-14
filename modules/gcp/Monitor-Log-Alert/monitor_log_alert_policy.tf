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

resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = join(" - ", ["[LOG]", var.alert_name, var.alert_environment])
  combiner     = "OR"
  enabled      = var.alert_enabled
  project      = var.project_name
  conditions {
    display_name = join("-", ["[LOG]", var.alert_name, var.alert_environment])
    condition_matched_log {
      filter = var.alert_query
    }
  }
  alert_strategy {
    auto_close = "1800s"
    notification_rate_limit {
      period = var.alert_period
    }
  }
  notification_channels = var.notification_channels_ids
  documentation {
    content   = "Choreo PDP service is outputting logs that contain the word '${var.alert_name}'."
    mime_type = "text/markdown"
  }
}
