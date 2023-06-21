# GLOBAL VARS
variable "notification_channels_id" {
    type        = string
}
variable "environment" {
    type        = string
}
variable "cluster_name" {
    type        = string
}

# GKE ALERT POLICY - Node Memory
variable "node_memory_duration" {
    type        = string
}
variable "node_memory_threshold_value" {
    type        = string
}
variable "node_memory_alignment_period" {
    type        = string
}
variable "node_memory_trigger_count" {
    type        = string
}

# GKE ALERT POLICY - Node CPU
variable "node_cpu_duration" {
    type        = string
}
variable "node_cpu_threshold_value" {
    type        = string
}
variable "node_cpu_alignment_period" {
    type        = string
}
variable "node_cpu_trigger_count" {
    type        = string
}