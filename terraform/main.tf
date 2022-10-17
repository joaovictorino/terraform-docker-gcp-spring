terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_container_registry" "container-registry" {
  project  = var.project
  location = "US"
}

resource "null_resource" "upload_image" {
  triggers = {
    order = google_container_registry.container-registry.id
  }
  provisioner "local-exec" {
    command = "docker push gcr.io/palestra-ici/springapp:latest"
  }
}

resource "google_cloud_run_service" "run-service" {
  name     = "run-service"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/palestra-ici/springapp:latest"

        env {
          name  = "MYSQL_INSTANCE"
          value = "${var.project}:${var.zone}:${google_sql_database_instance.db-service.name}"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    null_resource.upload_image
  ]
}

resource "google_cloud_run_service_iam_member" "run-service-all-members" {
  service  = google_cloud_run_service.run-service.name
  location = google_cloud_run_service.run-service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_sql_database_instance" "db-service" {
  name             = "db-service"
  region           = var.region
  database_version = "MYSQL_8_0"
  root_password    = "Teste@admin123"
  settings {
    tier = "db-f1-micro"
  }
  deletion_protection = false
}

resource "google_sql_database" "db-petclinic" {
  name     = "petclinic"
  instance = google_sql_database_instance.db-service.name
}

output "service-url" {
  value = google_cloud_run_service.run-service.status[0].url
}
