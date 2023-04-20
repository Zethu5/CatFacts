terraform {
  required_version = ">= 1.0"
}

provider "google" {
  project = "catfacts-384312"
  region  = "eu-west1"
}

data "github_secret" "GCP_CREDENTIALS" {
  secret_name = "GCP_CREDENTIALS"
}

resource "google_container_cluster" "cluster" {
  name               = "catfacts"
  location           = "eu-west1"
  remove_default_node_pool = false
}