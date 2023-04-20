terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "~> 3.0"
    }
    kubernetes = {
        source  = "hashicorp/kubernetes"
        version = ">= 2.0.0"
    }
  }
}

variable "GOOGLE_CREDENTIALS" {
  description = "Google Cloud Platform service account credentials"
}

provider "kubernetes" {
  host             = google_container_cluster.cluster.endpoint
  token            = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}

provider "google" {
  project = "catfacts-384312"
  region  = "europe-west1"
  credentials = var.GOOGLE_CREDENTIALS
}

resource "kubernetes_deployment" "catfacts" {
  metadata {
    name = "catfacts"
  }

  spec {
    selector {
      match_labels = {
        app = "catfacts"
      }
    }

    replicas = 3

    template {
      metadata {
        labels = {
          app = "catfacts"
        }
      }

      spec {
        container {
          name  = "catfacts"
          image = "zethu5/catfacts"

          port {
            container_port = 7777
          }
        }
      }
    }
  }
}
