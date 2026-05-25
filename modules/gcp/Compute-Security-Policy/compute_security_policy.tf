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

resource "google_compute_security_policy" "policy" {
  name            = join("-", compact([var.security_policy_abbreviation, var.policy_name]))
  description     = var.description
  project         = var.project_id
  type            = var.type
  labels          = var.labels
  deletion_policy = var.deletion_policy

  dynamic "advanced_options_config" {
    for_each = var.advanced_options_config != null ? [var.advanced_options_config] : []
    content {
      json_parsing                 = advanced_options_config.value.json_parsing
      log_level                    = advanced_options_config.value.log_level
      user_ip_request_headers      = advanced_options_config.value.user_ip_request_headers
      request_body_inspection_size = advanced_options_config.value.request_body_inspection_size

      dynamic "json_custom_config" {
        for_each = advanced_options_config.value.json_custom_config != null ? [advanced_options_config.value.json_custom_config] : []
        content {
          content_types = json_custom_config.value.content_types
        }
      }
    }
  }

  dynamic "adaptive_protection_config" {
    for_each = var.adaptive_protection_config != null ? [var.adaptive_protection_config] : []
    content {
      dynamic "layer_7_ddos_defense_config" {
        for_each = adaptive_protection_config.value.layer_7_ddos_defense_config != null ? [adaptive_protection_config.value.layer_7_ddos_defense_config] : []
        content {
          enable          = layer_7_ddos_defense_config.value.enable
          rule_visibility = layer_7_ddos_defense_config.value.rule_visibility

          dynamic "threshold_configs" {
            for_each = layer_7_ddos_defense_config.value.threshold_configs
            content {
              name                                    = threshold_configs.value.name
              auto_deploy_load_threshold              = threshold_configs.value.auto_deploy_load_threshold
              auto_deploy_confidence_threshold        = threshold_configs.value.auto_deploy_confidence_threshold
              auto_deploy_impacted_baseline_threshold = threshold_configs.value.auto_deploy_impacted_baseline_threshold
              auto_deploy_expiration_sec              = threshold_configs.value.auto_deploy_expiration_sec
              detection_load_threshold                = threshold_configs.value.detection_load_threshold
              detection_absolute_qps                  = threshold_configs.value.detection_absolute_qps
              detection_relative_to_baseline_qps      = threshold_configs.value.detection_relative_to_baseline_qps

              dynamic "traffic_granularity_configs" {
                for_each = threshold_configs.value.traffic_granularity_configs
                content {
                  type                     = traffic_granularity_configs.value.type
                  value                    = traffic_granularity_configs.value.value
                  enable_each_unique_value = traffic_granularity_configs.value.enable_each_unique_value
                }
              }
            }
          }
        }
      }

      dynamic "auto_deploy_config" {
        for_each = adaptive_protection_config.value.auto_deploy_config != null ? [adaptive_protection_config.value.auto_deploy_config] : []
        content {
          load_threshold              = auto_deploy_config.value.load_threshold
          confidence_threshold        = auto_deploy_config.value.confidence_threshold
          impacted_baseline_threshold = auto_deploy_config.value.impacted_baseline_threshold
          expiration_sec              = auto_deploy_config.value.expiration_sec
        }
      }
    }
  }

  dynamic "recaptcha_options_config" {
    for_each = var.recaptcha_options_config != null ? [var.recaptcha_options_config] : []
    content {
      redirect_site_key = recaptcha_options_config.value.redirect_site_key
    }
  }

  dynamic "rule" {
    for_each = var.rules
    content {
      action      = rule.value.action
      priority    = rule.value.priority
      description = rule.value.description
      preview     = rule.value.preview

      match {
        versioned_expr = rule.value.match.versioned_expr

        dynamic "config" {
          for_each = rule.value.match.config != null ? [rule.value.match.config] : []
          content {
            src_ip_ranges = config.value.src_ip_ranges
          }
        }

        dynamic "expr" {
          for_each = rule.value.match.expr != null ? [rule.value.match.expr] : []
          content {
            expression = expr.value.expression
          }
        }

        dynamic "expr_options" {
          for_each = rule.value.match.expr_options != null ? [rule.value.match.expr_options] : []
          content {
            recaptcha_options {
              action_token_site_keys  = expr_options.value.recaptcha_options.action_token_site_keys
              session_token_site_keys = expr_options.value.recaptcha_options.session_token_site_keys
            }
          }
        }
      }

      dynamic "rate_limit_options" {
        for_each = rule.value.rate_limit_options != null ? [rule.value.rate_limit_options] : []
        content {
          conform_action      = rate_limit_options.value.conform_action
          exceed_action       = rate_limit_options.value.exceed_action
          enforce_on_key      = length(rate_limit_options.value.enforce_on_key_configs) > 0 ? "" : rate_limit_options.value.enforce_on_key
          enforce_on_key_name = rate_limit_options.value.enforce_on_key_name
          ban_duration_sec    = rate_limit_options.value.ban_duration_sec

          rate_limit_threshold {
            count        = rate_limit_options.value.rate_limit_threshold.count
            interval_sec = rate_limit_options.value.rate_limit_threshold.interval_sec
          }

          dynamic "ban_threshold" {
            for_each = rate_limit_options.value.ban_threshold != null ? [rate_limit_options.value.ban_threshold] : []
            content {
              count        = ban_threshold.value.count
              interval_sec = ban_threshold.value.interval_sec
            }
          }

          dynamic "enforce_on_key_configs" {
            for_each = rate_limit_options.value.enforce_on_key_configs
            content {
              enforce_on_key_type = enforce_on_key_configs.value.enforce_on_key_type
              enforce_on_key_name = enforce_on_key_configs.value.enforce_on_key_name
            }
          }

          dynamic "exceed_redirect_options" {
            for_each = rate_limit_options.value.exceed_redirect_options != null ? [rate_limit_options.value.exceed_redirect_options] : []
            content {
              type   = exceed_redirect_options.value.type
              target = exceed_redirect_options.value.target
            }
          }
        }
      }

      dynamic "redirect_options" {
        for_each = rule.value.redirect_options != null ? [rule.value.redirect_options] : []
        content {
          type   = redirect_options.value.type
          target = redirect_options.value.target
        }
      }

      dynamic "header_action" {
        for_each = rule.value.header_action != null ? [rule.value.header_action] : []
        content {
          dynamic "request_headers_to_adds" {
            for_each = header_action.value.request_headers_to_adds
            content {
              header_name  = request_headers_to_adds.value.header_name
              header_value = request_headers_to_adds.value.header_value
            }
          }
        }
      }

      dynamic "preconfigured_waf_config" {
        for_each = rule.value.preconfigured_waf_config != null ? [rule.value.preconfigured_waf_config] : []
        content {
          dynamic "exclusion" {
            for_each = preconfigured_waf_config.value.exclusion
            content {
              target_rule_set = exclusion.value.target_rule_set
              target_rule_ids = exclusion.value.target_rule_ids

              dynamic "request_header" {
                for_each = exclusion.value.request_header
                content {
                  operator = request_header.value.operator
                  value    = request_header.value.value
                }
              }

              dynamic "request_cookie" {
                for_each = exclusion.value.request_cookie
                content {
                  operator = request_cookie.value.operator
                  value    = request_cookie.value.value
                }
              }

              dynamic "request_uri" {
                for_each = exclusion.value.request_uri
                content {
                  operator = request_uri.value.operator
                  value    = request_uri.value.value
                }
              }

              dynamic "request_query_param" {
                for_each = exclusion.value.request_query_param
                content {
                  operator = request_query_param.value.operator
                  value    = request_query_param.value.value
                }
              }
            }
          }
        }
      }
    }
  }
}
