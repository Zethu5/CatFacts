provider "google" {
  project = "catfacts-384312"
  region  = "eu-west1"
}

data "github_secret" "GOOGLE_CREDENTIALS" {
  secret_name = "GOOGLE_CREDENTIALS"
}

resource "google_container_cluster" "cluster" {
  name               = "catfacts"
  location           = "eu-west1"
  remove_default_node_pool = false
}