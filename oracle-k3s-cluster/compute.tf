resource "oci_core_instance" "server_1" {
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domain.ad.name
  display_name        = "${var.cluster_name}-k3s-server-1"
  fault_domain        = "FAULT-DOMAIN-1"
  shape               = local.server_instance_config_1.shape_id
  is_pv_encryption_in_transit_enabled = true
  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }
  source_details {
    source_id               = var.image_ocid
    source_type             = local.source_type
    boot_volume_size_in_gbs = local.server_instance_config_1.boot_volume
  }
  shape_config {
    memory_in_gbs = local.server_instance_config_1.ram
    ocpus         = local.server_instance_config_1.ocpus
  }
  create_vnic_details {
    subnet_id  = oci_core_subnet.cluster_subnet.id
    private_ip = local.server_ip_1
    nsg_ids    = [oci_core_network_security_group.nsg.id]
  }
  metadata = {
    "ssh_authorized_keys" = local.metadata.ssh_authorized_keys
    "user_data" = base64encode(
      templatefile("${path.module}/templates/server_user_data.sh",
        {
          server_1_ip    = local.server_ip_1,
          host_name      = "${var.cluster_name}-k3s-server-1",
          ssh_public_key = var.ssh_authorized_keys[0],
          token          = random_string.cluster_token.result,
          k3os_image     = var.k3os_image
      })
    )
  }
}

resource "oci_core_instance" "server_2" {
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domain.ad.name
  display_name        = "${var.cluster_name}-k3s-server-2"
  fault_domain        = "FAULT-DOMAIN-2"
  shape               = local.server_instance_config_1.shape_id
  is_pv_encryption_in_transit_enabled = true
  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }
  source_details {
    source_id               = var.image_ocid
    source_type             = local.source_type
    boot_volume_size_in_gbs = local.server_instance_config_1.boot_volume
  }
  shape_config {
    memory_in_gbs = local.server_instance_config_1.ram
    ocpus         = local.server_instance_config_1.ocpus
  }
  create_vnic_details {
    subnet_id  = oci_core_subnet.cluster_subnet.id
    private_ip = local.server_ip_2
    nsg_ids    = [oci_core_network_security_group.nsg.id]
  }
  metadata = {
    "ssh_authorized_keys" = local.metadata.ssh_authorized_keys
    "user_data" = base64encode(
      templatefile("${path.module}/templates/server_user_data.sh",
        {
          server_1_ip    = local.server_ip_1,
          host_name      = "${var.cluster_name}-k3s-server-2",
          ssh_public_key = var.ssh_authorized_keys[0],
          token          = random_string.cluster_token.result,
          k3os_image     = var.k3os_image
      })
    )
  }
  depends_on = [oci_core_instance.server_1]
}

resource "oci_core_instance" "server_3" {
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domain.ad.name
  display_name        = "${var.cluster_name}-k3s-server-3"
  fault_domain        = "FAULT-DOMAIN-3"
  shape               = local.server_instance_config_2.shape_id
  is_pv_encryption_in_transit_enabled = true
  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }
  source_details {
    source_id               = var.image_ocid
    source_type             = local.source_type
    boot_volume_size_in_gbs = local.server_instance_config_2.boot_volume
  }
  shape_config {
    memory_in_gbs = local.server_instance_config_2.ram
    ocpus         = local.server_instance_config_2.ocpus
  }
  create_vnic_details {
    subnet_id  = oci_core_subnet.cluster_subnet.id
    private_ip = local.server_ip_3
    nsg_ids    = [oci_core_network_security_group.nsg.id]
  }
  metadata = {
    "ssh_authorized_keys" = local.metadata.ssh_authorized_keys
    "user_data" = base64encode(
      templatefile("${path.module}/templates/server_user_data.sh",
        {
          server_1_ip    = local.server_ip_1,
          host_name      = "${var.cluster_name}-k3s-server-3",
          ssh_public_key = var.ssh_authorized_keys[0],
          token          = random_string.cluster_token.result,
          k3os_image     = var.k3os_image
      })
    )
  }
  depends_on = [oci_core_instance.server_1]
}
