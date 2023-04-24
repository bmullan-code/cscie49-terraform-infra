
resource "null_resource" "cluster" {

}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.prefix}-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "vpc_subnet" {
    name          = "${var.prefix}-subnet"
    ip_cidr_range = var.network_subnet_0_cidr
    region        = var.region
    network       = google_compute_network.vpc_network.id
}

# "10.1.0.0/24"
resource "google_compute_subnetwork" "vpc_subnet2" {
    name          = "${var.prefix}-subnet"
    ip_cidr_range = "10.1.2.0/24"
    region        = var.region
    network       = google_compute_network.vpc_network.id
}

resource "google_compute_router" "router" {
  name    = "${var.prefix}-router"
  region  = google_compute_subnetwork.vpc_subnet.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name    = "${var.prefix}-nat"
  router  = google_compute_router.router.name
  region  = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
