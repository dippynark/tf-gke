resource "random_id" "entropy" {
  byte_length = 6
}

resource "google_service_account" "default" {
  account_id   = "cluster-minimal-${random_id.entropy.hex}"
  display_name = "Minimal account for GKE cluster ${var.name}"
  project = "${var.project}"
}

resource "google_project_iam_binding" "logging-log-writer" {
  role    = "roles/logging.logWriter"
  project = "${var.project}"

  members = [
    "serviceAccount:${google_service_account.default.email}",
  ]
}

resource "google_project_iam_binding" "monitoring-metric-writer" {
  role    = "roles/monitoring.metricWriter"
  project = "${var.project}"

  members = [
    "serviceAccount:${google_service_account.default.email}",
  ]
}

resource "google_project_iam_binding" "monitoring-viewer" {
  role    = "roles/monitoring.viewer"
  project = "${var.project}"

  members = [
    "serviceAccount:${google_service_account.default.email}",
  ]
}

# uncomment when using private images in GCR
# https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster#use_least_privilege_sa
/*resource "google_project_iam_binding" "storage-object-viewer" {
  role    = "roles/storage.objectViewer"
  project = "${var.project}"

  members = [
    "serviceAccount:${google_service_account.default.email}",
  ]
}*/