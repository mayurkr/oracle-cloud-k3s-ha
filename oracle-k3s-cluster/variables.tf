variable "compartment_id" {
  description = "OCI Compartment ID"
  type        = string
}

variable "tenancy_ocid" {
  description = "The tenancy OCID."
  type        = string
}

variable "cluster_name" {
  description = "Cluster Prefix"
  type        = string
}

variable "ssh_authorized_keys" {
  description = "List of authorized SSH keys"
  type        = list(any)
}

variable "ssh_whitelist" {
  description = "IP address or IP address block to be whitelisted for SSH and KubeAPI access"
  type        = string
}

variable "kube_api_port" {
  type    = number
  default = 6443
}

variable "https_port" {
  type    = number
  default = 443
}

variable "http_port" {
  type    = number
  default = 80
}

variable "image_ocid" {
  type    = string
  default = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaagw3csfa4uxf4edrra2qghbvvf6rv6bsyebpw6eyctzog4ag4j4dq"
}

variable "k3os_image" {
  type    = string
  default = "https://github.com/rancher/k3os/releases/download/v0.21.5-k3s2r1/k3os-arm64.iso"
}

locals {
  source_type = "image"
  server_ip_1 = "10.0.0.11"
  server_ip_2 = "10.0.0.12"
  server_ip_3 = "10.0.0.13"
  metadata = {
    "ssh_authorized_keys" = join("\n", var.ssh_authorized_keys)
  }
  server_instance_config_1 = {
    shape_id    = "VM.Standard.A1.Flex"
    ocpus       = 1
    ram         = 6
    boot_volume = 50
  }
  server_instance_config_2 = {
    shape_id    = "VM.Standard.A1.Flex"
    ocpus       = 2
    ram         = 12
    boot_volume = 100
  }
}
