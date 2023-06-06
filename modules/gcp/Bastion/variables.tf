# variables.tf

variable "instance_name" {
  description = "Name of the bastion host"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the bastion host"
  type        = string
  default     = "n1-standard-1"
}


variable "region" {
  description = "Zone where the bastion host will be created"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zone where the bastion host will be created"
  type        = string
  default     = "us-central1-a"
}

variable "image" {
  description = "Image for the bastion host"
  type        = string
  default     = "debian-cloud/debian-10"
}

variable "network" {
  description = "Network for the bastion host"
  type        = string
  default     = "default"
}

variable "startup_script" {
  description = "StartupScript for the bastion host"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags for the bastion host"
  type        = list(string)
  default     = []
}

variable "project_id" {
  description = "ID of the GCP project"
  type        = string
}

variable "vpc_id" {
  description = "ID of the GCP project"
  # type        = string
}
