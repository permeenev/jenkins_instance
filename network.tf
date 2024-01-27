# Manage a network resource within VKCS
# External net (Internet) 
data "vkcs_networking_network" "extnet" {
   name = "ext-net"
}

# Manage a security group resource within VKCS
resource "vkcs_networking_secgroup" "secgroup" {
   name = "all_access"
   description = "Open all port"
}

resource "vkcs_networking_secgroup_rule" "all_acc" {
  description       = "Any inbound traffic from etcd hosts"
  security_group_id = vkcs_networking_secgroup.secgroup.id
  direction         = "ingress"
  remote_ip_prefix  = "0.0.0.0/0"
}