resource "random_password" "db_admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "db_user_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
  ADMIN_NAME     = "ap_admin"
  USER_NAME      = "ap_user"
  DATABASE       = "activepieces"
  ADMIN_PASSWORD = random_password.db_admin_password.result
  USER_PASSWORD  = random_password.db_user_password.result
}

resource "aws_ssm_parameter" "admin_name" {
  name      = "/${var.PREFIX}/POSTGRES/ADMIN_NAME"
  type      = "String"
  value     = local.ADMIN_NAME
  overwrite = true
}

resource "aws_ssm_parameter" "admin_password" {
  name      = "/${var.PREFIX}/POSTGRES/ADMIN_PASSWORD"
  type      = "SecureString"
  value     = local.ADMIN_PASSWORD
  overwrite = true
}


resource "aws_ssm_parameter" "user_name" {
  name      = "/${var.PREFIX}/POSTGRES/USER_NAME"
  type      = "String"
  value     = local.USER_NAME
  overwrite = true
}

resource "aws_ssm_parameter" "user_password" {
  name      = "/${var.PREFIX}/POSTGRES/USER_PASSWORD"
  type      = "SecureString"
  value     = local.USER_PASSWORD
  overwrite = true
}

