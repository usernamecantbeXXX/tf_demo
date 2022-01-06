terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("../gold-surface-337314-153bb977f7af.json")

  project = "gold-surface-337314"
  region  = "asia-east1"
  zone    = "asia-east1-c"
}

resource "google_compute_network" "vpc_network_xxx" {
  name = "terraform-network"
}


resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network_xxx.name
    access_config {
    }
  }
}
