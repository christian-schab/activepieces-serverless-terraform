data "terraform_remote_state" "tenant" {
  backend = "remote"

  config = {
    organization = "csyt"
    workspaces = {
      name = "csyt-tenant-${var.TENANT_ID}"
    }
  }
}

data "terraform_remote_state" "env" {
  backend = "remote"

  config = {
    organization = "csyt"
    workspaces = {
      name = "csyt-env-${var.TENANT_ID}-${var.STAGE}"
    }
  }
}

module "redis" {
  source = "./modules/core/redis"

  STAGE     = var.STAGE
  TENANT_ID = var.TENANT_ID
}

module "postgresql" {
  source = "./modules/core/postgresql"

  STAGE       = var.STAGE
  TENANT_ID   = var.TENANT_ID
  DB_PASSWORD = var.DB_PASSWORD
}
