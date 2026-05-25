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

variable "metric_abbreviation" {
  description = "Abbreviation prepended to the metric name via join. The forward-slash character (/) denotes a hierarchy of name pieces"
  type        = string
  default     = "metric"
}

variable "metric_name" {
  description = "The metric identifier. Valid characters: A-Z, a-z, 0-9, _-.,+!*',()%/. Cannot start with /"
  type        = string
}

variable "project_id" {
  description = "The ID of the project in which the metric will be created"
  type        = string
}

variable "filter" {
  description = "An advanced logs filter used to match log entries. See https://cloud.google.com/logging/docs/view/advanced-filters"
  type        = string
}

variable "description" {
  description = "A description of the metric used in documentation. Maximum 8000 characters"
  type        = string
  default     = null
}

variable "bucket_name" {
  description = "The resource name of the Log Bucket that owns this metric. The bucket must be in the same project as the metric. Omit to use the project's default log sink"
  type        = string
  default     = null
}

variable "disabled" {
  description = "If true, the metric is disabled and generates no data points"
  type        = bool
  default     = false
}

variable "deletion_policy" {
  description = "Policy for handling the log metric resource when the Terraform resource is destroyed"
  type        = string
  default     = "DELETE"
}

# ─── Metric Descriptor ────────────────────────────────────────────────────────
# If omitted, the provider creates a default DELTA/INT64 counter metric with no
# labels and a unit of "1".
#
# metric_kind valid values : DELTA | GAUGE | CUMULATIVE
# value_type  valid values : BOOL | INT64 | DOUBLE | STRING | DISTRIBUTION | MONEY
# label value_type         : BOOL | INT64 | STRING  (default: STRING)
#
# DISTRIBUTION metrics require value_extractor and bucket_options to also be set.
# Each label key defined here must have a corresponding entry in label_extractors.

variable "metric_descriptor" {
  description = "Defines the metric type and labels"
  type = object({
    metric_kind  = string
    value_type   = string
    unit         = optional(string)
    display_name = optional(string)
    labels = optional(list(object({
      key         = string
      value_type  = optional(string, "STRING") # BOOL | INT64 | STRING
      description = optional(string)
    })), [])
  })
  default = {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

variable "label_extractors" {
  description = "Map of label keys to log entry field paths used to extract label values"
  type        = map(string)
  default     = {}
}

variable "value_extractor" {
  description = "A log entry field path from which to extract the metric value"
  type        = string
  default     = null
}

# ─── Bucket Options ───────────────────────────────────────────────────────────
# Required when metric_descriptor.value_type is DISTRIBUTION.
# Exactly one of linear_buckets, exponential_buckets, or explicit_buckets must be set.
#
# linear_buckets      - Equal-width buckets. Good for uniformly distributed values
# exponential_buckets - Exponentially growing buckets. Good for latency / response size
# explicit_buckets    - Arbitrary bucket boundaries. Use when you know exact breakpoints

variable "bucket_options" {
  description = "Defines the bucket boundaries for DISTRIBUTION metrics"
  type = optional(object({
    linear_buckets = optional(object({
      num_finite_buckets = number
      width              = number
      offset             = number
    }))
    exponential_buckets = optional(object({
      num_finite_buckets = number
      growth_factor      = number
      scale              = number
    }))
    explicit_buckets = optional(object({
      bounds = list(number)
    }))
  }))
  default = null
}
