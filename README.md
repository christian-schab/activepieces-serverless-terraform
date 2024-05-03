# Serverless activepieces template for Terraform 

[activepieces](https://www.activepieces.com/) is an open-spource automation tool designed to be extensible through a type-safe pieces framework written in Typescript.

This template helps you deploy a serverless activepieces stack containing an [Aurora serverless v2 Postrgesql database](https://aws.amazon.com/rds/aurora/serverless/), a serverless Redis cluster hosted on [Upstash](https://upstash.com/) and activepieces Docker cluster running in [AWS Fargate](https://aws.amazon.com/fargate/)

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

Check file terraform.tfvars and modify credentials ans settings

### 3. Init Terraform

```
terraform init
```

### 3. Plan and apply stack

```
terraform apply
```
