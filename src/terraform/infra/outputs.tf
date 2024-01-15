output "project_id" {
  value = google_project.main.project_id
}
output "current_user" {
  value = data.google_client_openid_userinfo.provider_identity.email
}