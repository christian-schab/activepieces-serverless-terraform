
resource "aws_security_group" "ap_instances" {
  name = "${var.PREFIX}-ap-instances"

  ingress {
    description      = "Http from public"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    description      = "Outbound"
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "postgres_db" {
  name = "${var.PREFIX}-postgres-db"

  ingress {
    description      = "Postgresql from public"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

output "sg_ap_instances_id" {
  value = aws_security_group.ap_instances.id
}

output "sg_postgres_db_id" {
  value = aws_security_group.postgres_db.id
}
