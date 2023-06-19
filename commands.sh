#!/bin/bash

# Install Terraform
# Create GCP account
# Create Service Account
# Install gcloud cli

# Login and initialize cli
gcloud init
gcloud auth application-default login

# Create project
gcloud projects create "teste-sample" --name="teste-sample"

# Login Docker GCP
gcloud auth configure-docker

# Building jar
cd springapp
mvn package -DskipTests

# Building Docker image
cd ..
docker build -t springapp .

# Tag image GCP repository
docker tag springapp:latest us-central1-docker.pkg.dev/teste-sample-388301/ar-aula-spring/springapp:latest

# Upload image
docker push us-central1-docker.pkg.dev/teste-sample-388301/ar-aula-spring/springapp:latest
