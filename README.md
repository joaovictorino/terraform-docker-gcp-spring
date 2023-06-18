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
docker tag springapp:latest acraulaspring.azurecr.io/springapp:latest
```

Executar o Terraform

```sh
terraform apply -auto-approve
```

Logar no Registry do Azure

```sh
az acr login --name acraulaspring
```

Subir a imagem no Registry do Azure

```sh
docker push acraulaspring.azurecr.io/springapp:latest
```

Acessar a aplicação

```sh
curl http://aciaulaspring.eastus.azurecontainer.io
```
