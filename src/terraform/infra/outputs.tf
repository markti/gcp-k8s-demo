output "project_id" {
  value = google_project.main.project_id
}
output "current_user" {
  value = data.google_client_openid_userinfo.provider_identity.email
}
output "kubernetes_cluster_name" {
  value = google_container_cluster.main.name
}
output "primary_region" {
  value = var.primary_region
}