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

data "template_file" "startup_script" {
  template = <<-EOF
  sudo apt-get update -y
#   sudo apt-get install -y tinyproxy
#   curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
#   sudo apt-get install apt-transport-https --yes
#   echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
#   sudo apt-get update -y
#   sudo apt-get install helm -y
#   sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
#   curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#   sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
#   sudo apt-get update
#   sudo apt-get install docker-ce docker-ce-cli containerd.io -y
#   sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 -y
#   curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#   echo 'deb https://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
#   sudo apt-get update -y
#   sudo apt-get install -y kubectl
  EOF

}


resource "google_compute_instance" "bastion" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network       = var.network
    access_config = {}
  }

  metadata_startup_script = data.template_file.startup_script
  tags                    = var.tags
  allow_stopping_for_update = true
  deletion_protection      = false
  project                 = var.project_id
}
