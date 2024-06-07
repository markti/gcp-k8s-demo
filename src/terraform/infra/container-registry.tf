resource "google_artifact_registry_repository" "frontend" {
  location      = var.primary_region
  repository_id = "${var.application_name}-${var.environment_name}-${random_string.project_id.result}-frontend"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository" "backend" {
  location      = var.primary_region
  repository_id = "${var.application_name}-${var.environment_name}-${random_string.project_id.result}-backend"
  format        = "DOCKER"
}