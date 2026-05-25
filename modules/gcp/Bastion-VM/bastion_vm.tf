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
# Ignore: AVD-GCP-0030(https://avd.aquasec.com/misconfig/avd-gcp-0030)
# Reason: IDP is enabled for the bastion VM. SSH keys are not used for authentication.
# Ignore: AVD-GCP-0033(https://avd.aquasec.com/misconfig/avd-gcp-0033)
# Reason: Encryption is enabled and by default GCP managed key is used.
# Ignore: AVD-GCP-0067(https://avd.aquasec.com/misconfig/avd-gcp-0067)
# Reason: Shielded VM can be enabled if all the installations are required to be signed.

resource "google_compute_disk" "bastion_vm_data_disk" {
  name        = join("-", compact([var.data_disk_abbreviation, var.data_disk_name]))
  project     = var.project_id
  description = var.data_disk_description
  type        = var.data_disk_type
  zone        = var.data_disk_zone
  size        = var.data_disk_size_gb
  labels      = var.data_disk_labels
}

# trivy:ignore:AVD-GCP-0030
# trivy:ignore:AVD-GCP-0033
# trivy:ignore:AVD-GCP-0067
resource "google_compute_instance" "bastion_vm" {
  name         = join("-", compact([var.bastion_vm_abbreviation, var.name]))
  project      = var.project_id
  description  = var.description
  machine_type = var.bastion_vm_machine_type
  zone         = var.zone
  labels       = var.bastion_vm_labels
  tags         = var.bastion_vm_tags

  boot_disk {
    initialize_params {
      image  = var.boot_disk_image
      size   = var.boot_disk_size_gb
      type   = var.boot_disk_type
      labels = var.boot_disk_labels
    }
  }

  network_interface {
    network            = var.vpc_name
    subnetwork         = google_compute_subnetwork.bastion_subnetwork.self_link
    subnetwork_project = var.project_id
    network_ip         = var.bastion_vm_network_ip
  }

  shielded_instance_config {
    enable_vtpm                 = var.enable_vtpm
    enable_secure_boot          = var.enable_secure_boot
    enable_integrity_monitoring = var.enable_integrity_monitoring
  }

  metadata = {
    enable-oslogin         = var.enable_oslogin ? "TRUE" : "FALSE"
    block-project-ssh-keys = var.block_project_ssh_keys ? "TRUE" : "FALSE"
  }

  metadata_startup_script = var.metadata_startup_script

  service_account {
    email  = google_service_account.bastion_service_account.email
    scopes = ["cloud-platform"]
  }

  attached_disk {
    source      = google_compute_disk.bastion_vm_data_disk.self_link
    device_name = google_compute_disk.bastion_vm_data_disk.name
    mode        = "READ_WRITE"
  }
}
