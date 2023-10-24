provider "google" {
  credentials = var.credential_file
  project     = var.project
  region      = var.region
  zone        = var.zone
}

### EXTERNAL IP ###
resource "google_compute_address" "app_dev_ip" {
  provider = google
  name     = "dev-static-ip"
}

### SUBNET FOR BACKEND ###
resource "google_compute_subnetwork" "default" {
    name = "dev-subnet"
    provider = google
    ip_cidr_range = "10.0.1.0/24"
    region = var.region
    network = google_compute_network.default.id
}

resource "google_compute_instance" "dev" {

  name         = "dev"
  machine_type = "e2-standard-2"
  zone         = var.zone
  tags         = ["http-server", "https-server", "ssh", "dev-server"]

  boot_disk {
    initialize_params {
      image = "projects/rocky-linux-cloud/global/images/rocky-linux-8-optimized-gcp-v20230912"
      size  = 20
      type  = "pd-balanced"
    }
  }
  network_interface {
    network    = google_compute_network.default.id
    subnetwork = google_compute_subnetwork.default.id
    access_config {
      nat_ip = google_compute_address.app_dev_ip.address
    }
  }
  metadata_startup_script = file("bootstrap.sh")
  timeouts {
    create = "20m"
    update = "2h"
    delete = "20m"
  }
}