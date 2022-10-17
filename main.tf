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

resource "google_cloud_run_service" "run-service" {
  name     = "run-service"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/palestra-ici/springapp:latest"

        env {
          name  = "MYSQL_URL"
          value = "jdbc:mysql://tflab-mysqlserver-1-teste.mysql.database.azure.com:3306/exampledb?useSSL=true&requireSSL=false"
        }

        env {
          name  = "MYSQL_USER"
          value = "root"
        }

        env {
          name  = "MYSQL_PASS"
          value = "Teste@admin123"
        }
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

resource "google_sql_database_instance" "db-service" {
  name             = "db-service"
  region           = var.region
  database_version = "MYSQL_5_7"
  root_password    = "Teste@admin123"
  settings {
    tier = "db-f1-micro"
  }
  deletion_protection = false
}

resource "google_container_registry" "container-registry" {
  project  = var.project
  location = "US"
}

output "service-url" {
  value = google_cloud_run_service.run-service.status[0].url
}
