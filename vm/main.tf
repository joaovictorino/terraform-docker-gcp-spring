terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.5.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
}

resource "google_compute_network" "vpc-network" {
  name = "vpc-network"
}

resource "google_compute_instance" "vm-instance" {
  name         = "vm-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc-network.name
    access_config {}
  }
}

output "ip" {
  value = google_compute_instance.vm-instance.network_interface.0.access_config.0.nat_ip
}
