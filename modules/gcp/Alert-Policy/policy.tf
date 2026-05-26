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
  display_name          = var.alert_name
  combiner              = var.combiner
  enabled               = var.enabled
  notification_channels = var.notification_channels
  severity              = var.severity
  user_labels           = var.user_labels
  project               = var.project_id
  deletion_policy       = var.deletion_policy

  dynamic "conditions" {
    for_each = var.conditions
    content {
      display_name = conditions.value.display_name

      dynamic "condition_threshold" {
        for_each = conditions.value.condition_threshold != null ? [conditions.value.condition_threshold] : []
        content {
          filter                  = condition_threshold.value.filter
          comparison              = condition_threshold.value.comparison
          duration                = condition_threshold.value.duration
          threshold_value         = condition_threshold.value.threshold_value
          denominator_filter      = condition_threshold.value.denominator_filter
          evaluation_missing_data = condition_threshold.value.evaluation_missing_data

          dynamic "aggregations" {
            for_each = condition_threshold.value.aggregations
            content {
              alignment_period     = aggregations.value.alignment_period
              per_series_aligner   = aggregations.value.per_series_aligner
              cross_series_reducer = aggregations.value.cross_series_reducer
              group_by_fields      = aggregations.value.group_by_fields
            }
          }

          dynamic "denominator_aggregations" {
            for_each = condition_threshold.value.denominator_aggregations
            content {
              alignment_period     = denominator_aggregations.value.alignment_period
              per_series_aligner   = denominator_aggregations.value.per_series_aligner
              cross_series_reducer = denominator_aggregations.value.cross_series_reducer
              group_by_fields      = denominator_aggregations.value.group_by_fields
            }
          }

          dynamic "forecast_options" {
            for_each = condition_threshold.value.forecast_options != null ? [condition_threshold.value.forecast_options] : []
            content {
              forecast_horizon = forecast_options.value.forecast_horizon
            }
          }

          dynamic "trigger" {
            for_each = condition_threshold.value.trigger != null ? [condition_threshold.value.trigger] : []
            content {
              count   = trigger.value.count
              percent = trigger.value.percent
            }
          }
        }
      }

      dynamic "condition_absent" {
        for_each = conditions.value.condition_absent != null ? [conditions.value.condition_absent] : []
        content {
          filter   = condition_absent.value.filter
          duration = condition_absent.value.duration

          dynamic "aggregations" {
            for_each = condition_absent.value.aggregations
            content {
              alignment_period     = aggregations.value.alignment_period
              per_series_aligner   = aggregations.value.per_series_aligner
              cross_series_reducer = aggregations.value.cross_series_reducer
              group_by_fields      = aggregations.value.group_by_fields
            }
          }

          dynamic "trigger" {
            for_each = condition_absent.value.trigger != null ? [condition_absent.value.trigger] : []
            content {
              count   = trigger.value.count
              percent = trigger.value.percent
            }
          }
        }
      }

      dynamic "condition_monitoring_query_language" {
        for_each = conditions.value.condition_monitoring_query_language != null ? [conditions.value.condition_monitoring_query_language] : []
        content {
          query                   = condition_monitoring_query_language.value.query
          duration                = condition_monitoring_query_language.value.duration
          evaluation_missing_data = condition_monitoring_query_language.value.evaluation_missing_data

          dynamic "trigger" {
            for_each = condition_monitoring_query_language.value.trigger != null ? [condition_monitoring_query_language.value.trigger] : []
            content {
              count   = trigger.value.count
              percent = trigger.value.percent
            }
          }
        }
      }

      dynamic "condition_matched_log" {
        for_each = conditions.value.condition_matched_log != null ? [conditions.value.condition_matched_log] : []
        content {
          filter           = condition_matched_log.value.filter
          label_extractors = condition_matched_log.value.label_extractors
        }
      }

      dynamic "condition_prometheus_query_language" {
        for_each = conditions.value.condition_prometheus_query_language != null ? [conditions.value.condition_prometheus_query_language] : []
        content {
          query                     = condition_prometheus_query_language.value.query
          duration                  = condition_prometheus_query_language.value.duration
          evaluation_interval       = condition_prometheus_query_language.value.evaluation_interval
          labels                    = condition_prometheus_query_language.value.labels
          rule_group                = condition_prometheus_query_language.value.rule_group
          alert_rule                = condition_prometheus_query_language.value.alert_rule
          disable_metric_validation = condition_prometheus_query_language.value.disable_metric_validation
        }
      }

      dynamic "condition_sql" {
        for_each = conditions.value.condition_sql != null ? [conditions.value.condition_sql] : []
        content {
          query = condition_sql.value.query

          dynamic "minutes" {
            for_each = condition_sql.value.minutes != null ? [condition_sql.value.minutes] : []
            content {
              periodicity = minutes.value.periodicity
            }
          }

          dynamic "hourly" {
            for_each = condition_sql.value.hourly != null ? [condition_sql.value.hourly] : []
            content {
              periodicity   = hourly.value.periodicity
              minute_offset = hourly.value.minute_offset
            }
          }

          dynamic "daily" {
            for_each = condition_sql.value.daily != null ? [condition_sql.value.daily] : []
            content {
              periodicity = daily.value.periodicity

              dynamic "execution_time" {
                for_each = daily.value.execution_time != null ? [daily.value.execution_time] : []
                content {
                  hours   = execution_time.value.hours
                  minutes = execution_time.value.minutes
                  seconds = execution_time.value.seconds
                  nanos   = execution_time.value.nanos
                }
              }
            }
          }

          dynamic "row_count_test" {
            for_each = condition_sql.value.row_count_test != null ? [condition_sql.value.row_count_test] : []
            content {
              comparison = row_count_test.value.comparison
              threshold  = row_count_test.value.threshold
            }
          }

          dynamic "boolean_test" {
            for_each = condition_sql.value.boolean_test != null ? [condition_sql.value.boolean_test] : []
            content {
              column = boolean_test.value.column
            }
          }
        }
      }
    }
  }

  dynamic "documentation" {
    for_each = var.documentation != null ? [var.documentation] : []
    content {
      content   = documentation.value.content
      mime_type = documentation.value.mime_type
      subject   = documentation.value.subject

      dynamic "links" {
        for_each = documentation.value.links
        content {
          display_name = links.value.display_name
          url          = links.value.url
        }
      }
    }
  }

  dynamic "alert_strategy" {
    for_each = var.alert_strategy != null ? [var.alert_strategy] : []
    content {
      auto_close           = alert_strategy.value.auto_close
      notification_prompts = alert_strategy.value.notification_prompts

      dynamic "notification_rate_limit" {
        for_each = alert_strategy.value.notification_rate_limit != null ? [alert_strategy.value.notification_rate_limit] : []
        content {
          period = notification_rate_limit.value.period
        }
      }

      dynamic "notification_channel_strategy" {
        for_each = alert_strategy.value.notification_channel_strategy
        content {
          notification_channel_names = notification_channel_strategy.value.notification_channel_names
          renotify_interval          = notification_channel_strategy.value.renotify_interval
        }
      }
    }
  }
}
