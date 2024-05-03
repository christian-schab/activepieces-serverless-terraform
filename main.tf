module "security" {
  source = "./modules/core/security"

  PREFIX     = var.PREFIX
  AWS_REGION = var.AWS_REGION
}

module "redis" {
  source = "./modules/core/redis"

  depends_on = [module.security]

  PREFIX = var.PREFIX
}


module "postgresql" {
  source = "./modules/core/postgresql"

  PREFIX             = var.PREFIX
  SG_POSTGRES_DB_ID  = module.security.sg_postgres_db_id
  SG_AP_INSTANCES_ID = module.security.sg_ap_instances_id
}


module "ecs" {
  source = "./modules/core/ecs"

  depends_on = [module.postgresql, module.redis]

  PREFIX = var.PREFIX

  AWS_REGION     = var.AWS_REGION
  AWS_ACCOUNT_ID = var.AWS_ACCOUNT_ID
  AWS_VPC_ID     = var.AWS_VPC_ID

  DB_HOST = module.postgresql.host
  DB_PORT = module.postgresql.port
  DB_NAME = module.postgresql.database

  AP_EDITION        = var.AP_EDITION
  AP_EXECUTION_MODE = var.AP_EXECUTION_MODE
  AP_LICENSE_KEY    = var.AP_LICENSE_KEY
  AP_FRONTEND_URL   = var.AP_FRONTEND_URL

  DOCKER_IMAGE = var.DOCKER_IMAGE

  TASK_INSTANCES = var.TASK_INSTANCES
  TASK_CPU       = var.TASK_CPU
  TASK_MEMORY    = var.TASK_MEMORY

  IAM_EXECUTION_ROLE_ARN = module.security.iam_execution_role_arn
  IAM_TASK_ROLE_ARN      = module.security.iam_task_role_arn
  SG_AP_INSTANCES_ID     = module.security.sg_ap_instances_id
  SG_POSTGRES_DB_ID      = module.security.sg_postgres_db_id
}
