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
  environment_variables = {
    GOOGLE_CREDENTIALS = var.GOOGLE_CREDENTIALS
  }
}

variable "GOOGLE_CREDENTIALS" {
  description = "Google Cloud Platform service account credentials"
}

provider "google" {
  project = "catfacts-384312"
  region  = "eu-west1"
  credentials = var.GCP_CREDENTIALS
}

resource "google_container_cluster" "cluster" {
  name               = "catfacts"
  location           = "eu-west1"
  remove_default_node_pool = false
}