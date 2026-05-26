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

output "security_policy_id" {
  description = "The identifier of the security policy in the format projects/{{project}}/global/securityPolicies/{{name}}"
  value       = google_compute_security_policy.policy.id
  depends_on  = [google_compute_security_policy.policy]
}

output "security_policy_name" {
  description = "The name of the security policy"
  value       = google_compute_security_policy.policy.name
  depends_on  = [google_compute_security_policy.policy]
}

output "security_policy_self_link" {
  description = "The URI of the created security policy"
  value       = google_compute_security_policy.policy.self_link
  depends_on  = [google_compute_security_policy.policy]
}

output "security_policy_fingerprint" {
  description = "The fingerprint of the security policy"
  value       = google_compute_security_policy.policy.fingerprint
  depends_on  = [google_compute_security_policy.policy]
}
