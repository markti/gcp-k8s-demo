terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
  backend "gcs" {
  }
}

# Configure the GCP Provider
provider "google" {
  region = var.primary_region
}

data "google_container_cluster" "main" {
  name     = var.cluster_name
  location = "us-east1-a"
  project  = var.gcp_project
}

/*
provider "kubernetes" {

  host                   = var.host
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate

}
*/