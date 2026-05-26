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

resource "google_logging_metric" "logging_metric" {
  name             = join("-", compact([var.metric_abbreviation, var.metric_name]))
  filter           = var.filter
  project          = var.project_id
  description      = var.description
  bucket_name      = var.bucket_name
  disabled         = var.disabled
  label_extractors = var.label_extractors
  value_extractor  = var.value_extractor
  deletion_policy  = var.deletion_policy

  dynamic "metric_descriptor" {
    for_each = var.metric_descriptor != null ? [var.metric_descriptor] : []
    content {
      metric_kind  = metric_descriptor.value.metric_kind
      value_type   = metric_descriptor.value.value_type
      unit         = metric_descriptor.value.unit
      display_name = metric_descriptor.value.display_name

      dynamic "labels" {
        for_each = metric_descriptor.value.labels != null ? metric_descriptor.value.labels : []
        content {
          key         = labels.value.key
          value_type  = labels.value.value_type
          description = labels.value.description
        }
      }
    }
  }

  dynamic "bucket_options" {
    for_each = var.bucket_options != null ? [var.bucket_options] : []
    content {
      dynamic "linear_buckets" {
        for_each = bucket_options.value.linear_buckets != null ? [bucket_options.value.linear_buckets] : []
        content {
          num_finite_buckets = linear_buckets.value.num_finite_buckets
          width              = linear_buckets.value.width
          offset             = linear_buckets.value.offset
        }
      }

      dynamic "exponential_buckets" {
        for_each = bucket_options.value.exponential_buckets != null ? [bucket_options.value.exponential_buckets] : []
        content {
          num_finite_buckets = exponential_buckets.value.num_finite_buckets
          growth_factor      = exponential_buckets.value.growth_factor
          scale              = exponential_buckets.value.scale
        }
      }

      dynamic "explicit_buckets" {
        for_each = bucket_options.value.explicit_buckets != null ? [bucket_options.value.explicit_buckets] : []
        content {
          bounds = explicit_buckets.value.bounds
        }
      }
    }
  }
}
