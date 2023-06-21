# GKE ALERT POLICY - Node Memory
resource "google_monitoring_alert_policy" "node_memory_alert_policy" {
  display_name = join("-", ["[ALERT POLICY] - GKE Node Memory", var.environment])
  combiner     = "OR"
  conditions {
    display_name = join("-", ["[ALERT POLICY] - GKE Node Memory", var.environment])
    condition_threshold {
      filter          = "resource.type=\"k8s_node\" AND metric.type=\"kubernetes.io/node/memory/used_bytes\" AND resource.labels.cluster_name=\"${var.cluster_name}\""
      duration        = var.node_memory_duration
      comparison      = "COMPARISON_GT"
      threshold_value = var.node_memory_threshold_value #Bytes
      aggregations {
        alignment_period     = var.node_memory_alignment_period
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["resource.node_name","resource.cluster_name"]
      }

      trigger {
        count = var.node_memory_trigger_count
      }
    }

  }
  notification_channels = [
    var.notification_channels_id
  ]
}


# GKE ALERT POLICY - Node CPU
resource "google_monitoring_alert_policy" "node_cpu_alert_policy" {
  display_name = join("-", ["[ALERT POLICY] - GKE Node CPU", var.environment])
  combiner     = "OR"
  conditions {
    display_name = join("-", ["[ALERT POLICY] - GKE Node CPU", var.environment])
    condition_threshold {
      filter          = "resource.type=\"k8s_node\" AND metric.type=\"kubernetes.io/node/cpu/core_usage_time\" AND resource.labels.cluster_name=\"${var.cluster_name}\""
      duration        = var.node_cpu_duration
      comparison      = "COMPARISON_GT"
      threshold_value = var.node_cpu_threshold_value #Bytes
      aggregations {
        alignment_period     = var.node_cpu_alignment_period
        per_series_aligner   = "ALIGN_RATE"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["resource.node_name","resource.cluster_name"]
      }

      trigger {
        count = var.node_cpu_trigger_count
      }
    }

  }
  notification_channels = [
    var.notification_channels_id
  ]
}
