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

variable "security_policy_abbreviation" {
  description = "Abbreviation prepended to the security policy name via join"
  type        = string
  default     = "sp"
}

variable "policy_name" {
  description = "Name of the security policy"
  type        = string
}

variable "description" {
  description = "Optional description of the security policy. Max 2048 characters"
  type        = string
  default     = null
}

variable "project_id" {
  description = "The ID of the project in which the security policy will be created"
  type        = string
}

variable "type" {
  description = "Type of the security policy. Only CLOUD_ARMOR is currently supported"
  type        = string
  default     = "CLOUD_ARMOR"
}

variable "labels" {
  description = "Labels to apply to the security policy"
  type        = map(string)
  default     = {}
}

variable "deletion_policy" {
  description = "Policy for handling the security policy on deletion"
  type        = string
  default     = "DELETE"
}

# ─── Rules ────────────────────────────────────────────────────────────────────
# A default rule (priority 2147483647, match "*") must always be present.
# If no rules are supplied the provider will create a default allow rule automatically.
#
# Each rule requires exactly one of:
#   match.versioned_expr + match.config  — predefined IP-based matching (SRC_IPS_V1)
#   match.expr                           — CEL expression for custom logic
#
# rate_limit_options is required when action is "rate_based_ban" or "throttle".
# redirect_options  is required when action is "redirect".
# enforce_on_key_configs and enforce_on_key are mutually exclusive; the module
# sets enforce_on_key to "" automatically when enforce_on_key_configs is provided.

variable "rules" {
  description = "List of security policy rules. Must include a default rule at priority 2147483647"
  type = list(object({
    action      = string
    priority    = number
    description = optional(string)
    preview     = optional(bool, false)

    match = object({
      versioned_expr = optional(string)

      config = optional(object({
        src_ip_ranges = list(string)
      }))

      expr = optional(object({
        expression = string
      }))

      expr_options = optional(object({
        recaptcha_options = object({
          action_token_site_keys  = optional(list(string), [])
          session_token_site_keys = optional(list(string), [])
        })
      }))
    })

    rate_limit_options = optional(object({
      conform_action      = string
      exceed_action       = string
      enforce_on_key      = optional(string)
      enforce_on_key_name = optional(string)
      ban_duration_sec    = optional(number)

      rate_limit_threshold = object({
        count        = number
        interval_sec = number
      })

      ban_threshold = optional(object({
        count        = number
        interval_sec = number
      }))

      # When enforce_on_key_configs is non-empty, enforce_on_key is automatically set
      # to "" as required by the provider. Supports up to 3 entries.
      enforce_on_key_configs = optional(list(object({
        enforce_on_key_type = optional(string)
        enforce_on_key_name = optional(string)
      })), [])

      exceed_redirect_options = optional(object({
        type   = string
        target = optional(string)
      }))
    }))

    redirect_options = optional(object({
      type   = string           # EXTERNAL_302 | GOOGLE_RECAPTCHA
      target = optional(string) # Required for EXTERNAL_302
    }))

    header_action = optional(object({
      request_headers_to_adds = list(object({
        header_name  = string
        header_value = optional(string)
      }))
    }))

    preconfigured_waf_config = optional(object({
      exclusion = optional(list(object({
        target_rule_set = string
        target_rule_ids = optional(list(string), [])

        request_header = optional(list(object({
          operator = string
          value    = optional(string)
        })), [])

        request_cookie = optional(list(object({
          operator = string
          value    = optional(string)
        })), [])

        request_uri = optional(list(object({
          operator = string
          value    = optional(string)
        })), [])

        request_query_param = optional(list(object({
          operator = string
          value    = optional(string)
        })), [])
      })), [])
    }))
  }))
  default = []
}

# ─── Advanced Options ─────────────────────────────────────────────────────────

variable "advanced_options_config" {
  description = "Configuration for advanced features. All settings are optional and have no effect if not set"
  type = optional(object({
    json_parsing                 = optional(string, "DISABLED")
    log_level                    = optional(string, "NORMAL")
    user_ip_request_headers      = optional(list(string), [])
    request_body_inspection_size = optional(string)

    json_custom_config = optional(object({
      content_types = list(string)
    }))
  }))
  default = null
}

# ─── Adaptive Protection ──────────────────────────────────────────────────────

variable "adaptive_protection_config" {
  description = "Configuration for adaptive protection features. Only applicable for CLOUD_ARMOR type policies. All settings are optional and have no effect if not set."
  type = optional(object({
    layer_7_ddos_defense_config = optional(object({
      enable          = optional(bool, false)
      rule_visibility = optional(string, "STANDARD")

      threshold_configs = optional(list(object({
        name                                    = string
        auto_deploy_load_threshold              = optional(number)
        auto_deploy_confidence_threshold        = optional(number)
        auto_deploy_impacted_baseline_threshold = optional(number)
        auto_deploy_expiration_sec              = optional(number)
        detection_load_threshold                = optional(number)
        detection_absolute_qps                  = optional(number)
        detection_relative_to_baseline_qps      = optional(number)

        traffic_granularity_configs = optional(list(object({
          type                     = string # HTTP_HEADER_HOST | HTTP_PATH
          value                    = optional(string)
          enable_each_unique_value = optional(bool)
        })), [])
      })), [])
    }))

    auto_deploy_config = optional(object({
      load_threshold              = optional(number)
      confidence_threshold        = optional(number)
      impacted_baseline_threshold = optional(number)
      expiration_sec              = optional(number)
    }))
  }))
  default = null
}

# ─── reCAPTCHA ────────────────────────────────────────────────────────────────

variable "recaptcha_options_config" {
  description = "Configuration for reCAPTCHA-based redirects. Required when any rule has redirect_options.type GOOGLE_RECAPTCHA."
  type = optional(object({
    redirect_site_key = string
  }))
  default = null
}
