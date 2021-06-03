# terraform {
#   backend "gcs" {
#     bucket = "cc-org-iac-terraform-state"
#     prefix = "infrastructure/production/app"
#   }
# }

resource "google_compute_instance" "default" {
  name         = "codepipes-instance"
  machine_type = "n1-standard-1"
  zone         = "${var.region}-a"

  tags = ["web", "bar"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    owner = "aman.ludhwani"
  }

  metadata_startup_script = "apt-get update && apt-get upgrade -y && apt-get install nginx -y"
}

resource "google_compute_instance" "default-1" {
  name         = "codepipes-testing-1"
  machine_type = "n1-standard-1"
  zone         = "${var.region}-a"

  tags = ["bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    owner = "aman.ludhwani"
  }

  metadata_startup_script = "apt-get update && apt-get upgrade -y && apt-get install nginx -y"
}


resource "google_compute_firewall" "default" {
  name    = "codepipes"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000", "22"]
  }

  target_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}
