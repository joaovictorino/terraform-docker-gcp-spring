#!/bin/bash

# Install Terraform
# Create GCP account
# Create Service Account
# Install gcloud cli

gcloud init
gcloud auth application-default login

gcloud projects create "palestra-ICI" --name="paletra-ICI"

gcloud compute images list


