output "k3s_cluster_token" {
  value = module.k3s-cluster.cluster_token
}

output "cluster_name" {
  description = "Cluster name Prefix"
  value       = var.cluster_name
}

output "vcn_name" {
  description = "Cluster VCN name"
  value       = module.k3s-cluster.vcn
}

output "vcn_subnet" {
  description = "Cluster VCN Subnet Range"
  value       = module.k3s-cluster.vcn
}

output "availability_domain" {
  description = "Availability Domain of the Cluster"
  value       = module.k3s-cluster.ad
}

output "server-1_ip_address" {
  description = "Public IP address of Server 1"
  value       = module.k3s-cluster.server-1_ip_address
}

output "server-2_ip_address" {
  description = "Public IP address of Server 2"
  value       = module.k3s-cluster.server-2_ip_address
}

output "server-3_ip_address" {
  description = "Public IP address of Server 3"
  value       = module.k3s-cluster.server-3_ip_address
}

output "loadbalancer_ipaddress" {
  description = "Loadbalancer IP address"
  value       = module.k3s-cluster.loadbalancer_ip
}
