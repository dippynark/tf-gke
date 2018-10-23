resource "google_compute_network" "shared" {
  name = "${var.cluster_name}"
  project = "${var.project}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "shared" {
  name = "${var.cluster_name}"
  region = "${var.region}"
  project = "${var.project}"
  ip_cidr_range = "${var.ip_cidr_range}"
  network = "${google_compute_network.default.self_link}"
}