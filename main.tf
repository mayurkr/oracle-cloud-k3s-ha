module "k3s-cluster" {
  source              = "./oracle-k3s-cluster"
  cluster_name        = var.cluster_name
  compartment_id      = var.compartment_id
  tenancy_ocid        = var.tenancy_ocid
  ssh_authorized_keys = var.ssh_authorized_keys
  image_ocid          = var.image_ocid
  ssh_whitelist       = var.ssh_whitelist
}
