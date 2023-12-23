resource "google_project" "main" {
  name       = "${var.application_name}-${var.environment_name}"
  project_id = "${var.application_name}-${var.environment_name}"
  org_id     = var.gcp_organization
}