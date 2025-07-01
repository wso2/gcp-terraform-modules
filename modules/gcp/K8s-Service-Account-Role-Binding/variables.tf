# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "service_account_roles" {
  type        = list(string)
  description = "The service account roles"
  default = [
    "roles/iam.workloadIdentityUser",
    "roles/iam.serviceAccountTokenCreator"
  ]
}
variable "service_account_id" {
  description = "The service account ID"
  type        = string
}
variable "service_account_member" {
  description = "The service account member"
  type        = string
}
variable "project_id" {
  description = "The project ID"
  type        = string
}
variable "kubernetes_namespace" {
  description = "The Kubernetes namespace"
  type        = string
}
variable "kubernetes_service_account_name" {
  description = "The Kubernetes service account name"
  type        = string
}
