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

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "database_abbreviation" {
  description = "Abbreviation to be used in the database name"
  type        = string
  default     = "db"
}

variable "database_name" {
  description = "Name of the database to be created in the SQL instance."
  type        = string
}

variable "database_instance_name" {
  description = "Name of the SQL instance where the database will be created."
  type        = string
}

variable "charset" {
  description = "The character set of the database. If not specified, the default value is 'utf8'."
  type        = string
  default     = "utf8"
}

variable "collation" {
  description = "The collation of the database. If not specified, the default value is 'utf8_general_ci'."
  type        = string
  default     = "utf8_general_ci"
}
