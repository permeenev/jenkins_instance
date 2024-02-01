variable "jenkins_image_flavor" {
  type = string
  default = "Ubuntu-22.04-202208"
}

variable "jenkins_flavor" {
  type = string
  default = "STD2-4-8"
}

variable "key_pair_name" {
  type = string
  default = "Ubuntu-STD2-6-6-20GB-Vfgdw8fg"
}

variable "availability_zone_name" {
  type = string
  default = "GZ1"
}