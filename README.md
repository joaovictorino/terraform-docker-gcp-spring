## Terraform ambiente PaaS no GCP, usando Cloud SQL MySQL e Cloud Run

Pré-requisitos

- gcloud instalado
- Terraform instalado

Logar no GCP via gcloud, o navegador será aberto para que o login seja feito

```sh
gcloud auth login
```

Inicializar o Terraform

```sh
terraform init
```

Compilar a imagem Dockerfile localmente

```sh
docker build -t springapp .
```

Renomear a imagem

```sh
docker tag springapp:latest us-central1-docker.pkg.dev/teste-sample-388301/ar-aula-spring/springapp:latest
```

Executar o Terraform

```sh
terraform apply -auto-approve
```
