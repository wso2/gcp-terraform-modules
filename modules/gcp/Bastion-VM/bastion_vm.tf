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
resource "google_compute_instance" "bastion_vm" {
  name         = join("-", ["vmbastion", var.project, var.location])
  project      = var.project
  description  = join(" ", ["Bastion VM for", var.project])
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      labels = {
        boot_disk = "ubuntu-2204-lts"
      }
    }
  }
  network_interface {
    network = var.vpc_name
    subnetwork_project = var.project
    subnetwork = var.subnetwork_id

    access_config {
    }
  }
  metadata  = {
   ssh-keys = file(var.ssh_public_key_path)
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt-get update
    # Install Helm
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    # Install kubectl
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    sudo apt update
    sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin kubectl
    export USE_GKE_GCLOUD_AUTH_PLUGIN=True
    EOF

  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

}
