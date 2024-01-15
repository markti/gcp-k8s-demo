resource "google_service_account" "cluster" {
  project      = google_project.main.id
  account_id   = "sa-gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
  display_name = "sa-gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
}

/*
resource "google_container_cluster" "main" {
  name     = "gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
  location = var.primary_region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary" {
  name       = "gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}-primary"
  location   = var.primary_region
  cluster    = google_container_cluster.main.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.cluster.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
*/