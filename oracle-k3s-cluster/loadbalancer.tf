resource "oci_network_load_balancer_network_load_balancer" "k3s_load_balancer" {
  compartment_id                 = var.compartment_id
  display_name                   = "${var.cluster_name}-k3s-loadbalancer"
  subnet_id                      = oci_core_subnet.cluster_subnet.id
  network_security_group_ids     = [oci_core_network_security_group.nsg.id]
  is_private                     = false
  is_preserve_source_destination = false
}

// Kube API (6443) Listener

resource "oci_network_load_balancer_listener" "k3s_kube_api_listener" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3s_kube_api_backend_set.name
  name                     = "${var.cluster_name}-kube_api_listener"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  port                     = var.kube_api_port
  protocol                 = "TCP"
}

resource "oci_network_load_balancer_backend_set" "k3s_kube_api_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = var.kube_api_port
  }

  name                     = "${var.cluster_name}-k3s_kube_api_backend"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  policy                   = "FIVE_TUPLE"
  is_preserve_source       = true
}

resource "oci_network_load_balancer_backend" "k3s_kube_api_backend-server-1" {
  backend_set_name         = oci_network_load_balancer_backend_set.k3s_kube_api_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  name                     = format("%s:%s", oci_core_instance.server_1.display_name, var.kube_api_port)
  port                     = var.kube_api_port
  target_id                = oci_core_instance.server_1.id
}

resource "oci_network_load_balancer_backend" "k3s_kube_api_backend-server-2" {
  backend_set_name         = oci_network_load_balancer_backend_set.k3s_kube_api_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  name                     = format("%s:%s", oci_core_instance.server_2.display_name, var.kube_api_port)
  port                     = var.kube_api_port
  target_id                = oci_core_instance.server_2.id
}

resource "oci_network_load_balancer_backend" "k3s_kube_api_backend-server-3" {
  backend_set_name         = oci_network_load_balancer_backend_set.k3s_kube_api_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  name                     = format("%s:%s", oci_core_instance.server_3.display_name, var.kube_api_port)
  port                     = var.kube_api_port
  target_id                = oci_core_instance.server_3.id
}

// HTTPS (443) Listener

resource "oci_network_load_balancer_listener" "https_listener" {
  depends_on = [
    oci_network_load_balancer_backend.k3s_kube_api_backend-server-1,
    oci_network_load_balancer_backend.k3s_kube_api_backend-server-2,
    oci_network_load_balancer_backend.k3s_kube_api_backend-server-3,
  ]
  default_backend_set_name = oci_network_load_balancer_backend_set.https_backend_set.name
  name                     = "HTTPS Listener"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  port                     = var.https_port
  protocol                 = "TCP"
}

resource "oci_network_load_balancer_backend_set" "https_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = var.https_port
  }

  name                     = "${var.cluster_name}-https_backend_set"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  policy                   = "FIVE_TUPLE"
  is_preserve_source       = true
}

resource "oci_network_load_balancer_backend" "https_backend-server-1" {
  backend_set_name         = oci_network_load_balancer_backend_set.https_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  name                     = format("%s:%s", oci_core_instance.server_1.display_name, var.https_port)
  port                     = var.https_port
  target_id                = oci_core_instance.server_1.id
}

resource "oci_network_load_balancer_backend" "https_backend-server-2" {
  backend_set_name         = oci_network_load_balancer_backend_set.https_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  name                     = format("%s:%s", oci_core_instance.server_2.display_name, var.https_port)
  port                     = var.https_port
  target_id                = oci_core_instance.server_2.id
}

resource "oci_network_load_balancer_backend" "https_backend-server-3" {
  backend_set_name         = oci_network_load_balancer_backend_set.https_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  name                     = format("%s:%s", oci_core_instance.server_3.display_name, var.https_port)
  port                     = var.https_port
  target_id                = oci_core_instance.server_3.id
}

// HTTP (80) Listner

resource "oci_network_load_balancer_listener" "http_listener" {
  depends_on = [
    oci_network_load_balancer_backend.https_backend-server-1,
    oci_network_load_balancer_backend.https_backend-server-2,
    oci_network_load_balancer_backend.https_backend-server-3,
  ]
  default_backend_set_name = oci_network_load_balancer_backend_set.http_backend_set.name
  name                     = "HTTP Listener"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  port                     = var.http_port
  protocol                 = "TCP"
}

resource "oci_network_load_balancer_backend_set" "http_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = var.http_port
  }

  name                     = "${var.cluster_name}-http_backend_set"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  policy                   = "FIVE_TUPLE"
  is_preserve_source       = true
}

resource "oci_network_load_balancer_backend" "http_backend-server-1" {
  backend_set_name         = oci_network_load_balancer_backend_set.http_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  name                     = format("%s:%s", oci_core_instance.server_1.display_name, var.http_port)
  port                     = var.http_port
  target_id                = oci_core_instance.server_1.id
}

resource "oci_network_load_balancer_backend" "http_backend-server-2" {
  backend_set_name         = oci_network_load_balancer_backend_set.http_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  name                     = format("%s:%s", oci_core_instance.server_2.display_name, var.http_port)
  port                     = var.http_port
  target_id                = oci_core_instance.server_2.id
}

resource "oci_network_load_balancer_backend" "http_backend-server-3" {
  backend_set_name         = oci_network_load_balancer_backend_set.http_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_load_balancer.id
  name                     = format("%s:%s", oci_core_instance.server_3.display_name, var.http_port)
  port                     = var.http_port
  target_id                = oci_core_instance.server_3.id
}
