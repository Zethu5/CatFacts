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

variable "ENDPOINT" {
  description = "Kubernetes cluster external endpoint"
}

provider "kubernetes" {
  host             = "https://${var.ENDPOINT}"
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
