resource "google_container_registry" "main" {
  project  = google_project.main.id
  location = var.container_registry_location
}