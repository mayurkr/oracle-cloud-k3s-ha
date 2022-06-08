variable "compartment_id" {
  description = "OCI Compartment ID"
  type        = string
}

variable "fingerprint" {
  description = "The fingerprint of the key to use for signing"
  type        = string
}

variable "private_key_path" {
  description = "The path to the private key to use for signing"
  type        = string
}

variable "region" {
  description = "The region to connect to. Default: eu-frankfurt-1"
  type        = string
  default     = "ap-mumbai-1"
}

variable "tenancy_ocid" {
  description = "The tenancy OCID."
  type        = string
}

variable "user_ocid" {
  description = "The user OCID."
  type        = string
}

variable "ssh_authorized_keys" {
  description = "List of authorized SSH keys"
  type        = list(any)
}

variable "image_ocid" {
  description = "Image OCID"
  type        = string

}

variable "cluster_name" {
  description = "Name of the K3s Cluster"
  type        = string
}

variable "ssh_whitelist" {
  description = "IP address or IP address block to be whitelisted for SSH and KubeAPI access"
  type        = string
}
