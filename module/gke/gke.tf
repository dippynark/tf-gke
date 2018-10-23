resource "google_container_cluster" "cluster" {
  name = "${var.name}"
  region = "${var.region}"
  additional_zones = "${var.zones}"
  provider = "google-beta"
  min_master_version = "${var.min_master_version}"
  network = "${google_compute_network.default.self_link}"
  subnetwork = "${google_compute_subnetwork.default.self_link}"

  ip_allocation_policy {
    create_subnetwork = true
    subnetwork_name = "${var.name}"
  }

  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "${var.master_authorized_cidr}"
    }
  }

  network_policy {
    enabled = true
    provider = "CALICO"
  }

  pod_security_policy_config {
    enabled = true
  }

/*
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes = true
    master_ipv4_cidr_block = "${var.master_ipv4_cidr_block}"
  }
*/

  addons_config {
    network_policy_config {
      disabled = false
    }
    kubernetes_dashboard {
      disabled = true
    }
  }

  lifecycle {
    ignore_changes = ["node_pool"]
  }

  node_pool {
    name = "default-pool"
  }
}

resource "google_container_node_pool" "default-pool" {
  name = "default-pool"
  initial_node_count = "${var.autoscaling_min_node_count}"
  cluster    = "${google_container_cluster.cluster.name}"

  autoscaling {
    min_node_count = "${var.autoscaling_min_node_count}"
    max_node_count = "${var.autoscaling_max_node_count}"
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "${var.machine_type}"

    service_account = "${google_service_account.default.email}"

    workload_metadata_config {
      node_metadata = "SECURE"
    }
  }
}