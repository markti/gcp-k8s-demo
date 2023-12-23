resource "google_project" "main" {
  name       = "${var.application_name}-${var.environment_name}"
  project_id = "${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
  org_id     = var.gcp_organization
}

resource "random_string" "project_id" {
  length  = 8
  special = false
}