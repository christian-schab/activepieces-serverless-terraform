resource "upstash_redis_database" "redis_db" {
  database_name = "${var.PREFIX}__activepieces-db"
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

resource "aws_ssm_parameter" "redis_url" {
  name      = "/${var.PREFIX}/REDIS/URL"
  type      = "SecureString"
  value     = "rediss://default:${upstash_redis_database.redis_db.password}@${upstash_redis_database.redis_db.endpoint}:${upstash_redis_database.redis_db.port}"
  overwrite = true
}


