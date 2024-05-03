provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}


provider "upstash" {
  email   = var.UPSTASH_EMAIL
  api_key = var.UPSTASH_API_KEY
}


