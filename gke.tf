resource "google_service_account" "gke" {
  account_id   = "service-account-gke"
  display_name = "Service Account for GKE clusters"
}

resource "google_container_cluster" "primary" {
  name       = "${var.project_id}-gke"
  location   = "us-central1-a"
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  initial_node_count = 3
  node_config {
    service_account = google_service_account.gke.email
    tags            = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    disk_size_gb = 10
    oauth_scopes = [
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}
