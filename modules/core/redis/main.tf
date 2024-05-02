resource "upstash_redis_database" "redis_db" {
  database_name = "${var.STAGE}__${var.TENANT_ID}-activepieces-db"
  region = "eu-central-1"
  tls = "true"
}

output "redis_db_endpoint" {
  value = upstash_redis_database.redis_db.endpoint
}

output "redis_db_password" {
  value = upstash_redis_database.redis_db.password
}

output "redis_db_port" {
  value = upstash_redis_database.redis_db.port
}


