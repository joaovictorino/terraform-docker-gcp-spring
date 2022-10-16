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

resource "google_cloud_run_service" "run-service" {
  name     = "run-service"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/google-samples/hello-app:1.0"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "run-service-all-members" {
  service  = google_cloud_run_service.run-service.name
  location = google_cloud_run_service.run-service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "service-url" {
  value = google_cloud_run_service.run-service.status[0].url
}
