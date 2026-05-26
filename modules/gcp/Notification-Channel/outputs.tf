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

output "channel_id" {
  description = "The identifier of the notification channel (matches the name field)"
  value       = google_monitoring_notification_channel.channel.id
  depends_on  = [google_monitoring_notification_channel.channel]
}

output "channel_name" {
  description = "The full REST resource name of the notification channel in the format projects/[PROJECT_ID]/notificationChannels/[CHANNEL_ID]"
  value       = google_monitoring_notification_channel.channel.name
  depends_on  = [google_monitoring_notification_channel.channel]
}

output "verification_status" {
  description = "Indicates whether this channel has been verified"
  value       = google_monitoring_notification_channel.channel.verification_status
  depends_on  = [google_monitoring_notification_channel.channel]
}
