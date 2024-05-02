terraform {
  backend "remote" {
    organization = "csyt"

    workspaces {
      prefix = "csyt-activepieces-"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.0"
    }

    github = {
      source  = "integrations/github"
      version = "5.3.0"
    }

    upstash = {
      source = "upstash/upstash"
      version = "1.3.0"
    }
  }

  required_version = ">= 0.14.9"
}
