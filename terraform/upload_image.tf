resource "null_resource" "upload_image" {
  triggers = {
    order = google_artifact_registry_repository.ar-aula-spring.id
  }
  provisioner "local-exec" {
    command = "gcloud auth configure-docker us-central1-docker.pkg.dev && docker push us-central1-docker.pkg.dev/teste-sample-388301/ar-aula-spring/springapp:latest"
  }
}
