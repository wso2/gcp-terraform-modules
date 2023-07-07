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

resource "google_monitoring_alert_policy" "metric_alert_policy" {
  display_name = join("-", ["[METRIC]", var.alert_name, var.alert_environment])
  combiner     = "OR"
  enabled      = var.alert_enabled
  project      = var.project_name
  conditions {
    display_name = join("-", ["[METRIC]", var.alert_name, var.alert_environment])
    condition_threshold {
      filter          = var.alert_metric_filter
      duration        = var.alert_duration
      comparison      = "COMPARISON_GT"
      threshold_value = var.alert_threshold_value
      aggregations {
        alignment_period     = var.alert_alignment_period
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = var.alert_group_by_fields
      }

      trigger {
        count = var.alert_trigger_count
      }
    }
  }
  notification_channels = var.notification_channels_ids
}
