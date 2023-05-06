# gke cluster

resource "google_container_cluster" "primary" {
  name = "${var.prefix}-${var.project_id}-gke"
  # location = var.region
  location = var.zone
  remove_default_node_pool = true
  initial_node_count = 1

  network    = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnet.self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = "${var.prefix}-${var.project_id}-cluster"
    services_secondary_range_name = "${var.prefix}-${var.project_id}-services"
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}"
  # location   = var.region
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/pubsub",
      "https://www.googleapis.com/auth/trace.append",
    ]
    labels = {
      env = var.project_id
    }
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
