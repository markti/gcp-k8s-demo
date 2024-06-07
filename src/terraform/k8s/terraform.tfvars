application_name = "fleet-ops"
environment_name = "dev"
k8s_namespace    = "app"
web_app_image = {
  name    = "fleetops-frontend"
  version = "2024.06.3"
}
web_api_image = {
  name    = "fleetops-backend"
  version = "2024.06.10"
}