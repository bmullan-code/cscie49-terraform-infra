# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.prefix}-${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnets
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.prefix}-${var.project_id}-subnet"
  ip_cidr_range = "10.255.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc.name

  secondary_ip_range {
    range_name    = "${var.prefix}-${var.project_id}-cluster"
    ip_cidr_range = "10.0.0.0/12"
  }

  secondary_ip_range {
    range_name    = "${var.prefix}-${var.project_id}-services"
    ip_cidr_range = "10.16.0.0/12"
  }
}
