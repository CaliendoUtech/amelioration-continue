provider "google" {
  project = "votre-projet-id"
  region  = "us-central1" # Remplacez par votre région préférée
  zone    = "us-central1-a" # Remplacez par votre zone préférée
}

resource "google_compute_instance" "vm_spot" {
  name         = "spot-instance"
  machine_type = "e2-micro" # Choisissez un type de machine adapté
  zone         = var.zone

  scheduling {
    preemptible       = true # Active le mode Spot
    on_host_maintenance = "TERMINATE"
    automatic_restart   = false # Recommandé pour les instances Spot
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # Remplacez par l'image désirée
      size  = 10 # Taille du disque en Go
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Permet un accès via une IP publique
    }
  }
}

variable "zone" {
  description = "La zone dans laquelle la machine virtuelle sera créée."
  default     = "us-central1-a"
}