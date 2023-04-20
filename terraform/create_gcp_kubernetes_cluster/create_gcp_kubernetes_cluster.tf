terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.0"
    }
    github = {
      source = "hashicorp/github"
      version = "~> 4.11.0"
    }
  }
}

variable "GOOGLE_CREDENTIALS" {
  description = "Google Cloud Platform service account credentials"
}

provider "google" {
  project = "catfacts-384312"
  region  = "europe-west1"
  credentials = var.GOOGLE_CREDENTIALS
}

resource "google_container_cluster" "cluster" {
  name               = "catfacts"
  location           = "europe-west1"
  remove_default_node_pool = true
  node_pool {
    name = "default-pool"

    # Minimum values for nodes
    node_config {
      machine_type = "e2-micro"
      disk_size_gb = 10
      disk_type    = "pd-standard"
    }

    initial_node_count = 3
    autoscaling = false
  }
}