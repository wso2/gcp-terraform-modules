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

locals {
  log_based_pagerduty_alerts_configs = {
    for alert_configs in var.pagerduty_alert_policy_configs :
    alert_configs.alert_display_name => {
      filter                 = alert_configs.filter
      notification_channels  = alert_configs.notification_channels
      condition_display_name = alert_configs.condition_display_name
      alert_strategy         = alert_configs.alert_strategy
      content                = alert_configs.content
    }
  }
  log_based_email_alerts_configs = {
    for alert_configs in var.email_alert_policy_configs :
    alert_configs.alert_display_name => {
      filter                 = alert_configs.filter
      notification_channels  = alert_configs.notification_channels
      condition_display_name = alert_configs.condition_display_name
      alert_strategy         = alert_configs.alert_strategy
      content                = alert_configs.content
    }
  }
}

data "google_monitoring_notification_channel" "pagerduty_channels" {

  count        = length(var.pagerduty_alert_policy_configs) > 0 ? length(var.pagerduty_alert_policy_configs[0].notification_channels) : 0
  display_name = var.pagerduty_alert_policy_configs[0].notification_channels[count.index]
}

resource "google_monitoring_alert_policy" "pagerduty_alert_policy" {
  for_each     = local.log_based_pagerduty_alerts_configs
  display_name = each.key
  documentation {
    content   = each.value.content
    mime_type = "text/markdown"
  }
  enabled = true
  alert_strategy {
    notification_rate_limit {
      period = each.value.alert_strategy.period
    }
    auto_close = each.value.alert_strategy.auto_close
  }
  notification_channels = data.google_monitoring_notification_channel.pagerduty_channels[*].id
  combiner              = "OR"
  conditions {
    display_name = each.value.condition_display_name
    condition_matched_log {
      filter = each.value.filter
    }
  }
}

data "google_monitoring_notification_channel" "email_channels" {

  count        = length(var.email_alert_policy_configs) > 0 ? length(var.email_alert_policy_configs[0].notification_channels) : 0
  display_name = var.email_alert_policy_configs[0].notification_channels[count.index]
}


resource "google_monitoring_alert_policy" "email_alert_policy" {
  for_each     = local.log_based_email_alerts_configs
  display_name = each.key
  documentation {
    content   = each.value.content
    mime_type = "text/markdown"
  }
  enabled = true
  alert_strategy {
    notification_rate_limit {
      period = each.value.alert_strategy.period
    }
    auto_close = each.value.alert_strategy.auto_close
  }
  notification_channels = data.google_monitoring_notification_channel.email_channels[*].id
  combiner              = "OR"
  conditions {
    display_name = each.value.condition_display_name
    condition_matched_log {
      filter = each.value.filter
    }
  }
}
