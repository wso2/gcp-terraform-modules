# GLOBAL VARS
variable "notification_channels_id" {
  type = string
}
variable "environment" {
  type = string
}
variable "cluster_name" {
  type = string
}

# GKE ALERT POLICY - Container Memory
variable "container_memory_duration" {
  type = string
}
variable "container_memory_threshold_value" {
  type = string
}
variable "container_memory_alignment_period" {
  type = string
}
variable "container_memory_trigger_count" {
  type = string
}

# GKE ALERT POLICY - Container CPU
variable "container_cpu_duration" {
  type = string
}
variable "container_cpu_threshold_value" {
  type = string
}
variable "container_cpu_alignment_period" {
  type = string
}
variable "container_cpu_trigger_count" {
  type = string
}

variable "filter" {
  type = string
}
variable "scope" {
  type = string
}
