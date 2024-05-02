resource "aws_security_group" "public_postgres_db" {
  name = "${var.STAGE}-${var.TENANT_ID}-public-postgresql-db"

  ingress {
    description      = "Postgresql from public"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = "${var.STAGE}-${var.TENANT_ID}-activepieces"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "16.2"
  database_name      = var.TENANT_ID
  master_username    = "${var.TENANT_ID}_admin"
  master_password    = var.DB_PASSWORD

  vpc_security_group_ids = [aws_security_group.public_postgres_db.id]

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
