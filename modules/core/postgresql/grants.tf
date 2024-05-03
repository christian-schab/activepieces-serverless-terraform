
provider "postgresql" {
  host            = aws_rds_cluster.aurora_cluster.endpoint
  port            = aws_rds_cluster.aurora_cluster.port
  database        = local.DATABASE
  username        = local.ADMIN_NAME
  password        = local.ADMIN_PASSWORD
  sslmode         = "require"
  connect_timeout = 15

  superuser = false

}

resource "postgresql_role" "user_role" {
  depends_on = [time_sleep.wait_for_dns]

  name     = local.USER_NAME
  login    = true
  password = local.USER_PASSWORD

}

resource "postgresql_grant" "user_grant_database" {
  depends_on = [postgresql_role.user_role]

  database    = local.DATABASE
  role        = local.USER_NAME
  schema      = "public"
  object_type = "database"
  privileges  = ["CONNECT", "CREATE", "TEMPORARY"]
}

resource "postgresql_grant" "user_grant_schema" {
  depends_on = [postgresql_role.user_role]
  database    = local.DATABASE
  role        = local.USER_NAME
  schema      = "public"
  object_type = "schema"
  privileges  = ["CREATE", "USAGE"]
}

