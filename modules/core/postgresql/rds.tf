
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = "${var.PREFIX}-activepieces-db"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "16.2"
  database_name      = local.DATABASE
  master_username    = local.ADMIN_NAME
  master_password    = local.ADMIN_PASSWORD

  skip_final_snapshot = true

  vpc_security_group_ids = [var.SG_POSTGRES_DB_ID, var.SG_AP_INSTANCES_ID]

  serverlessv2_scaling_configuration {
    max_capacity = 2.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "aurora_serverless_instance" {
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.aurora_cluster.engine
  engine_version      = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = true
}

resource "time_sleep" "wait_for_dns" {
  depends_on = [aws_rds_cluster.aurora_cluster, aws_rds_cluster_instance.aurora_serverless_instance]

  create_duration = "3m"
}


