# Oracle Cloud Infrastructure k3s Cluster

This is a Terraform project that helps you to deploy a fault tolerant and production grade Kubernetes cluster on Oracle Cloud without spending a dime.

Create `terraform.tfvars` as follows:

    fingerprint         = "add me"  # Oracle Cloud Configuration
    private_key_path    = "add me"  # Oracle Cloud Configuration
    user_ocid           = "add me"  # Oracle Cloud Configuration
    tenancy_ocid        = "add me"  # Oracle Cloud Configuration
    compartment_id      = "add me"  # Oracle Cloud Configuration
    region              = "add me"  # Oracle Cloud Configuration
    ssh_authorized_keys = ["add me"] # Add your Public SSH key
    image_ocid          = "add me"  # Added the Latest Image OCID for Ubuntu aarch64
    cluster_name        = "add me"  # Cluster name (it will be appended as a prefix to your resources)
    ssh_whitelist       = "add me"  # You public IP block to whitelist SSH and KubeAPI access. Example: 1.2.3.4/32

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >= 4.78.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_k3s-cluster"></a> [k3s-cluster](#module\_k3s-cluster) | ./k3s-cluster | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the K3s Cluster | `string` | n/a | yes |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | OCI Compartment ID | `string` | n/a | yes |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | The fingerprint of the key to use for signing | `string` | n/a | yes |
| <a name="input_image_ocid"></a> [image\_ocid](#input\_image\_ocid) | Image OCID | `string` | n/a | yes |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | The path to the private key to use for signing | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to connect to. Default: eu-frankfurt-1 | `string` | `"ap-mumbai-1"` | no |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | List of authorized SSH keys | `list(any)` | n/a | yes |
| <a name="input_ssh_whitelist"></a> [ssh\_whitelist](#input\_ssh\_whitelist) | IP address or IP address block to be whitelisted for SSH and KubeAPI access | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The tenancy OCID. | `string` | n/a | yes |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | The user OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_domain"></a> [availability\_domain](#output\_availability\_domain) | Availability Domain of the Cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster name Prefix |
| <a name="output_k3s_cluster_token"></a> [k3s\_cluster\_token](#output\_k3s\_cluster\_token) | n/a |
| <a name="output_loadbalancer_ipaddress"></a> [loadbalancer\_ipaddress](#output\_loadbalancer\_ipaddress) | Loadbalancer IP address |
| <a name="output_server-1_ip_address"></a> [server-1\_ip\_address](#output\_server-1\_ip\_address) | Public IP address of Server 1 |
| <a name="output_server-2_ip_address"></a> [server-2\_ip\_address](#output\_server-2\_ip\_address) | Public IP address of Server 2 |
| <a name="output_server-3_ip_address"></a> [server-3\_ip\_address](#output\_server-3\_ip\_address) | Public IP address of Server 3 |
| <a name="output_vcn_name"></a> [vcn\_name](#output\_vcn\_name) | Cluster VCN name |
| <a name="output_vcn_subnet"></a> [vcn\_subnet](#output\_vcn\_subnet) | Cluster VCN Subnet Range |
<!-- END_TF_DOCS -->