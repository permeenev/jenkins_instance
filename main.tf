# Jenkins instance describe
data "vkcs_compute_flavor" "jenkins_flavor" {
  name = var.jenkins_flavor
}

data "vkcs_images_image" "jenkins_image" {
  name = var.jenkins_image_flavor
}

resource "vkcs_compute_instance" "jenkins_instance" {
  name                    = "jenkins_instance"
  flavor_id               = data.vkcs_compute_flavor.jenkins_flavor.id
  key_pair                = var.key_pair_name
  security_groups         = ["default","ssh","all_access"]
  availability_zone       = var.availability_zone_name
  # Use block_device to specify instance disk to get full control of it in the futur
  block_device {
    uuid                  = data.vkcs_images_image.jenkins_image.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 20
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = data.vkcs_networking_network.extnet.id
  }
}

# Deploy instance describe
data "vkcs_compute_flavor" "deploy_flavor" {
  name = var.deploy_flavor
}

data "vkcs_images_image" "deploy_image" {
  name = var.deploy_image_flavor
}

resource "vkcs_compute_instance" "deploy_instance" {
  name                    = "deploy_instance"
  flavor_id               = data.vkcs_compute_flavor.deploy_flavor.id
  key_pair                = var.key_pair_name
  security_groups         = ["default","ssh","all_access"]
  availability_zone       = var.availability_zone_name

  block_device {
    uuid                  = data.vkcs_images_image.deploy_image.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 15
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = data.vkcs_networking_network.extnet.id
  }
}