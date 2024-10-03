provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

data "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = "us-central1-a"
}

provider "helm" {
  kubernetes {
    host = "https://${data.google_container_cluster.primary.endpoint}"
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
    )
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "gke-gcloud-auth-plugin"
    }
  }
}

