# Serverless activepieces template for Terraform

[activepieces](https://www.activepieces.com/) is an open-spource automation tool designed to be extensible through a
type-safe pieces framework written in Typescript.

This template helps you deploy a serverless activepieces stack containing
an [Aurora serverless v2 Postrgesql database](https://aws.amazon.com/rds/aurora/serverless/), a serverless Redis cluster
hosted on [Upstash](https://upstash.com/) and activepieces Docker cluster running
in [AWS Fargate](https://aws.amazon.com/fargate/)

## Goal

This stack is designed to have a minimum of running costs and having capabilities to scale effortless at the same time.

## Prerequisites

### AWS

You need an AWS account and the following credentials / infos:

- AWS Account Key
- AWS Secret Key
- AWS Account ID
- AWS VPC ID

If you have no AWS yet, you can register here
[https://aws.amazon.com/](https://aws.amazon.com/)

### Upstash

You need an Upstash account the follwing credentials:

- Email address
- API Key

If you have no Upstash account yet, you can register here
[https://upstash.com/](https://upstash.com/)

### Terraform

You need a working Terraform environment.
If you haven't Terraform installed yet, check it out here:
[How to install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Usage

### 1. Clone repository

```
git clone https://github.com/coasy/activepieces-serverless-terraform.git
cd activepieces-serverless-terraform
```

### 2. Modify variables

Check file terraform.tfvars and modify credentials and settings.

Detailed explanation can be found here: [Variables](#variables)

### 3. Init Terraform

```
terraform init
```

### 3. Plan and apply stack

```
terraform apply
```

### 4. Launch Browser
The terraform apply ends with the output of an endpoint.

It takes a couple of minutes and then the activepieces frontend should be available through this endpoint.

## Variables

| Name                  | Description                                                   |
|-----------------------|---------------------------------------------------------------|
| PREFIX                | Name of your stack, used as a prefix for components           |
| AWS_ACCOUNT_ID        | ID (numeric) of your AWS accout                               |
| AWS_VPC_ID            | ID (starts with vpc-) of your preferred / default VPC         |
| AWS_ACCESS_KEY_ID     | Acces Key of your AWS Account                                 |
| AWS_SECRET_ACCESS_KEY | Secret Key of your AWS Account                                |
| UPSTASH_EMAIL         | Email address of your Upstash account                         |
| UPSTASH_API_KEY       | API Key for your Upstash account                              |
| TASK_INSTANCES        | Number of instances to run activepieces                       |
| TASK_CPU              | CPU units per task instance (2048 = 2vCPU)                    |
| TASK_MEMORY           | Memory units per task instance (4096 = 4GB)                   |
| DOCKER_IMAGE          | URL to docker image (default = "activepieces/activepieces")   |
| AP_FRONTEND_URL       | Url that will be used to specify redirect url and webhook url. |
| AP_FRONTEND_URL       | Url that will be used to specify redirect url and webhook url. |
| AP_EDITION            | (ce = Community Edition, ee = Enterprise Edition)             |




