resource "google_cloud_run_service" "run-service" {
  name     = "run-service"
  location = var.region

  template {
    spec {
      containers {
        image = "us-central1-docker.pkg.dev/teste-sample-388301/ar-aula/springapp:latest"

        env {
          name  = "MYSQL_INSTANCE"
          value = google_sql_database_instance.db-service.connection_name
        }

        env {
          name  = "MYSQL_DB"
          value = var.db_name
        }

        env {
          name  = "MYSQL_USER"
          value = var.db_user
        }

        env {
          name  = "MYSQL_PASS"
          value = var.db_pass
        }

        ports {
          container_port = 80
        }

      }
    }

    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.db-service.connection_name
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    null_resource.upload_image,
    google_sql_database.db-petclinic
  ]
}

resource "google_cloud_run_service_iam_member" "run-service-all-members" {
  service  = google_cloud_run_service.run-service.name
  location = google_cloud_run_service.run-service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
