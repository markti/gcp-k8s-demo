# gcp-k8s-demo
# aws-k8s-demo

# Welcome

This codebase is a sample solution from the book [Mastering Terraform](https://amzn.to/3XNjHhx). This codebase is the solution from Chapter 14 where Soze Enterprises is deploying their solution with Docker and Kubernetes using Google Kubernetes Engine (GKE). It includes container configuration with Docker, and both infrastructure and Kubernetes configuration using Terraform.

## Docker Code

The Docker code is stored in two `Dockerfile` files for both the `frontend` and another for the `backend`. As with convention, the `Dockerfile` for the corresponding application code is stored in the root folder of the application code which is stored in `src\dotnet`.

## Terraform Code

The Terraform code is stored in `src\terraform`. However, there are two root modules. One for the AWS infrastructure that leverages the `google` provider in the `src\terraform\infra` folder and another for the Kubernetes configuration that leverages the `kubernetes` and `helm` Terraform providers residing in the `src\terraform\k8s` folder.

### Google Cloud Infrastructure
The Terraform root module that provisions the AWS infrastructure will provision both an AWS Elastic Container Registry, an Elastic Kubernetes Service (EKS) cluster and all surrounding resources. The Elastic Container Registry is required in order to build and publish the Docker images.

You may need to change the `primary_region` input variable value if you wish to deploy to a different region. The default is `us-central1`.

### Kubernetes Configuration

After you build Docker Images you will need to update the input variables `web_app_image` and `web_api_image` to reference the correct Docker image tag.

If you want to provision more than one environment you may need to remove the `environment_name` input variable value and specify an additional environment `tfvar` file.

## GitHub Actions Workflows

### Docker Workflows
There are two GitHub Actions workflows that use Docker to build and push the container images. These need to be executed after Terraform has been used to provision the Google Cloud infrastructure.

### Terraform Workflows
The directory `.github/workflows/` contains GitHub Actions workflows that implement a CI/CD solution using Docker and Terraform. There are individual workflows for the three Terraform core workflow operations `plan`, `apply`, and `destroy`.

# Pre-Requisites

## Google Cloud Setup

### Shared Projects

In order to save Terraform state you need to create a shared Google Cloud Project that Terraform can use as its backend. In this project you should create a Cloud Storage Bucket.

### IAM Service Accounts

In order for GitHub Actions workflows to execute you need to have an identity that they can use to access Google Cloud. Therefore you need to setup a new Service Account for the Terraform workflows.

You'll need to download the credentials in JSON format and set them as Environment Variables in GitHub.

The Service Account for Terraform should have it's credentials stored in a GitHub environment Variable `GOOGLE_APPLICATION_CREDENTIALS`. Optionally you can create a separate service account to control access to the Terraform State backend. You can either store this identity's credential or the Terraform Service Account's credential in another GitHub environment variable `GOOGLE_BACKEND_CREDENTIALS`.

### IAM Permissions

The Terraform State Service Account needs to be cranted the following project-level permissions to the 'Terraform State' Project.

- Service Account Token Creator
- Storage Object Admin

The Terraform Service Account needs to be added as a member to the `gcp-organization-admins` group.

### GitHub Configuration

You need to add the following environment variables:

- GCP_ORGANIZATION_ID
- PACKER_PROJECT_ID
- BACKEND_BUCKET_NAME

You need to add the following secrets:

- GOOGLE_APPLICATION_CREDENTIALS
- GOOGLE_BACKEND_CREDENTIALS
- PACKER_CREDENTIALS

## Kubernetes Cheat Sheet

Get the credentials for your EKS cluster so you can connect using `kubectl`

```
aws eks update-kubeconfig --name eks-fleet-portal-dev
```

Verify connectivity by checking on the nodes

```
kubectl get nodes
```

Check that the ALB load balancer ingress controller is deployed:

```
kubectl get deployments -n ingress-nginx
```

Check that the front end pods are running:

```
kubectl get pods -n app
```

Check the pod to see if the secrets are accessible from the environment variable.
```
kubectl -n app exec -it fleet-api-67646d7db4-58l8n -- sh
```

gcloud auth activate-service-account --key-file=./gcp-key.json

gcloud components install gke-gcloud-auth-plugin

gcloud container clusters get-credentials gke-fleet-ops-dev-ci3m88hs --region us-central1 --project fleet-ops-dev-ci3m88hs

kubectl get svc -n ingress-nginx

https://cloud.google.com/kubernetes-engine/docs/concepts/workload-identity