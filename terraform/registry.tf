resource "google_artifact_registry_repository" "ar-aula" {
  location      = var.region
  repository_id = "ar-aula"
  format        = "DOCKER"
}
