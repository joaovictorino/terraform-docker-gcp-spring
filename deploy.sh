#!/bin/bash

docker build -t springapp .

docker tag springapp:latest us-central1-docker.pkg.dev/teste-sample-388301/ar-aula-spring/springapp:latest

cd terraform

terraform init

terraform apply -auto-approve
