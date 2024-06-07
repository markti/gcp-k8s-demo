resource "google_service_account" "cluster" {
  project      = google_project.main.project_id
  account_id   = "sa-gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
  display_name = "sa-gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
}


resource "google_container_cluster" "main" {
  project  = google_project.main.project_id
  name     = "gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
  location = var.primary_region
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

  network    = google_compute_network.main.self_link
  subnetwork = google_compute_subnetwork.backend.self_link

}

resource "google_container_node_pool" "primary" {

  project    = google_project.main.project_id
  name       = "gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}-primary"
  location   = var.primary_region
  cluster    = google_container_cluster.main.name
  node_count = var.node_count

  node_config {

    preemptible  = false
    spot         = false
    machine_type = var.node_size

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.cluster.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

  }
}

locals {
  cluster_admin_roles = [
    "roles/container.clusterAdmin",
    "roles/container.developer",
    "roles/container.viewer"
  ]
}

resource "google_project_iam_member" "terraform_cluster_admin" {

  count = length(local.cluster_admin_roles)

  project = google_project.main.project_id
  member  = "serviceAccount:${data.google_client_openid_userinfo.provider_identity.email}"
  role    = local.cluster_admin_roles[count.index]

}