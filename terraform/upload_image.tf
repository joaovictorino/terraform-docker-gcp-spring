resource "null_resource" "upload_image" {
  triggers = {
    order = google_container_registry.container-registry.id
  }
  provisioner "local-exec" {
    command = "docker push gcr.io/palestra-ici/springapp:latest"
  }
}
