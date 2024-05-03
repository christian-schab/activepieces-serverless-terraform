terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46"
    }

    upstash = {
      source = "upstash/upstash"
      version = "1.3.0"
    }

    postgresql = {
      source = "NitriKx/postgresql"
      version = "1.21.2"
    }
  }

  required_version = ">= 0.14.9"
}
