terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.61.0"
    }
  }
  backend "gcs" {
    bucket  = "cscie49-terraform-state"
    prefix  = "terraform/state"
  }
}

# cscie49-terraform-state
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  alias = "impersonation"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_service_account_access_token" "default" {
  provider               	= google.impersonation
  target_service_account 	= var.terraform_service_account
  scopes                 	= ["userinfo-email", "cloud-platform"]
  lifetime               	= "1200s"
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  access_token	= data.google_service_account_access_token.default.access_token
  request_timeout 	= "60s"
}