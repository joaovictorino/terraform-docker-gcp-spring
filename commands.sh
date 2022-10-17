#!/bin/bash

# Install Terraform
# Create GCP account
# Create Service Account
# Install gcloud cli

# Login and initialize cli
gcloud init
gcloud auth application-default login

# Create project
gcloud projects create "palestra-ICI" --name="paletra-ICI"

# List VM images
gcloud compute images list

# Login Docker GCP
gcloud auth configure-docker

# Tag image GCP repository
docker tag springapp:latest gcr.io/palestra-ici/springapp:latest

# Upload image
docker push gcr.io/palestra-ici/springapp:latest
