variable "registry_endpoint" {
  description = "The endpoint of the container registry"
  type        = string
}
variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "namespace" {
  type = string
}
variable "web_app_image" {
  type = object({
    name    = string
    version = string
  })
}
variable "web_api_image" {
  type = object({
    name    = string
    version = string
  })
}
variable "backend_endpoint" {
  type = string
}
variable "host" {
  type = string
}
variable "client_certificate" {
  type = string
}
variable "client_key" {
  type = string
}
variable "cluster_ca_certificate" {
  type = string
}