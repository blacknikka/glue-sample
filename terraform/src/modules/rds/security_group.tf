resource "aws_security_group" "praivate_db_sg" {
  name   = "praivate-db-sg"
  vpc_id = var.vpc_main.id
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = var.source_security_group_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-db-sg"
  }
}
