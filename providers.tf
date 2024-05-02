provider "aws" {
  region     = data.terraform_remote_state.tenant.outputs.AWS_REGION
  access_key = data.terraform_remote_state.tenant.outputs.AWS_ACCESS_KEY
  secret_key = data.terraform_remote_state.tenant.outputs.AWS_SECRET_KEY
}

provider "cloudflare" {
  email   = data.terraform_remote_state.tenant.outputs.CF_EMAIL
  api_key = data.terraform_remote_state.tenant.outputs.CF_API_KEY
}

provider "github" {
  token = data.terraform_remote_state.tenant.outputs.GITHUB_TOKEN
  owner = "coasy"
  #  organization = "coasy"
}

provider "upstash" {
  email   = data.terraform_remote_state.env.outputs.UPSTASH_EMAIL
  api_key = data.terraform_remote_state.env.outputs.UPSTASH_API_KEY
}
