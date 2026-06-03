# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

resource "google_sql_database_instance" "instance" {
  name                     = join("-", compact([var.database_abbreviation, var.database_instance_name]))
  region                   = var.region
  database_version         = var.database_version
  deletion_protection      = var.deletion_protection
  project                  = var.project_id
  root_password            = var.root_password
  root_password_wo         = var.root_password_wo
  root_password_wo_version = var.root_password_wo_version

  settings {
    tier              = var.database_tier
    user_labels       = var.user_labels
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_type         = var.disk_type
    disk_autoresize   = var.disk_autoresize

    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = var.network
      ssl_mode        = var.ssl_mode

      dynamic "authorized_networks" {
        for_each = coalesce(var.authorized_networks, [])
        content {
          expiration_time = authorized_networks.value.expiration_time
          name            = authorized_networks.value.name
          value           = authorized_networks.value.value
        }
      }
    }

    dynamic "insights_config" {
      for_each = var.insights_config_enabled ? [1] : []
      content {
        query_insights_enabled  = var.query_insights_enabled
        query_string_length     = var.query_string_length
        record_application_tags = var.record_application_tags
        record_client_address   = var.record_client_address
      }
    }

    dynamic "backup_configuration" {
      for_each = var.backup_configuration_enabled ? [1] : []
      content {
        enabled                        = var.backup_enabled
        binary_log_enabled             = var.binary_log_enabled
        transaction_log_retention_days = var.transaction_log_retention_days
        dynamic "backup_retention_settings" {
          for_each = var.backup_retention_settings_enabled ? [1] : []
          content {
            retained_backups = var.retained_backups
            retention_unit   = var.retention_unit
          }
        }
      }
    }

    dynamic "maintenance_window" {
      for_each = var.maintenance_window_enabled ? [1] : []
      content {
        day          = var.maintenance_window_day
        hour         = var.maintenance_window_hour
        update_track = var.maintenance_window_update_track
      }
    }

    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = database_flags.key
        value = database_flags.value
      }
    }
  }

  depends_on = [google_service_networking_connection.network_connection]
}

resource "google_sql_user" "user" {
  project             = var.project_id
  name                = var.username
  instance            = google_sql_database_instance.instance.name
  password            = var.password
  password_wo         = var.password_wo
  password_wo_version = var.password_wo_version
  type                = var.user_type
}
