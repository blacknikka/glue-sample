# RDS
resource "aws_db_subnet_group" "praivate_db" {
  name       = "${var.db_name}-subnet"
  subnet_ids = [var.rds_subnet_1.id, var.rds_subnet_2.id]
  tags = {
    Name = "${var.db_name}"
  }
}

resource "aws_db_instance" "rdb" {
  identifier             = "${var.db_name}-rdb"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "11.5"
  instance_class         = "db.t2.micro"
  name                   = "etl"
  username               = "etl_user"
  password               = "secretsecret"
  vpc_security_group_ids = [aws_security_group.praivate_db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.praivate_db.name
  skip_final_snapshot    = true
}
