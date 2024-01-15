resource "google_container_registry" "main" {
  project  = google_project.main.name
  location = var.container_registry_location
}