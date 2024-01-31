# Manage a network resource within VKCS
# Internet 
data "vkcs_networking_network" "extnet" {
   name = "ext-net"
}
# Local net 
resource "vkcs_networking_network" "network" {
   name = "net"
}

resource "vkcs_networking_subnet" "subnetwork" {
   name       = "subnet_1"
   network_id = vkcs_networking_network.network.id
   cidr       = "192.168.199.0/24"
}

resource "vkcs_networking_router" "router" {
   name                = "router"
   admin_state_up      = true
   external_network_id = data.vkcs_networking_network.extnet.id
}
resource "vkcs_networking_router_interface" "intrface" {
   router_id = vkcs_networking_router.router.id
   subnet_id = vkcs_networking_subnet.subnetwork.id
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