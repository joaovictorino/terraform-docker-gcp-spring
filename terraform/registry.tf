resource "google_container_registry" "container-registry" {
  project  = var.project
  location = "US"
}
