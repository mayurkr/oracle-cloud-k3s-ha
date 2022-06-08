output "ad" {
  value = data.oci_identity_availability_domain.ad.name
}

output "cluster_token" {
  value = random_string.cluster_token.result
}

output "vcn" {
  description = "Created VCN"
  value       = oci_core_vcn.cluster_network
}

output "cluster_subnet" {
  description = "Subnet of the k3s cluser"
  value       = oci_core_subnet.cluster_subnet
}

output "server-1_ip_address" {
  description = "Public IP address of Server 1"
  value       = oci_core_instance.server_1.public_ip
}

output "server-2_ip_address" {
  description = "Public IP address of Server 2"
  value       = oci_core_instance.server_2.public_ip
}

output "server-3_ip_address" {
  description = "Public IP address of Server 3"
  value       = oci_core_instance.server_3.public_ip
}

output "loadbalancer_ip" {
  description = "Network Loadbalancer IP address"
  value       = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.ip_addresses
}
