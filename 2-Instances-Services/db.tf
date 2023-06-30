#Creation of a subnet group only for the database. It is important to creation of database.

resource "aws_db_subnet_group" "test-elva-db-subnet-group" {
  name       = "test-elva db subnet group"
  subnet_ids = [var.private_subnet_1_id, var.private_subnet_2_id, var.private_subnet_3_id]

  tags = {
    Name = "TEST-ELVA-DB-SUBNET-GROUP"
  }
}

#Creation of database
resource "aws_db_instance" "test-elva-db" {
  identifier             = "test-elva-dpl-db-rds"
  instance_class         = var.db_instance_class
  allocated_storage      = 50
  engine                 = "aurora-mysql"
  engine_version         = "5.7.mysql_aurora.2.11.2"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.test-elva-db-subnet-group.name
  vpc_security_group_ids = [var.sg_private]
  publicly_accessible    = false
  skip_final_snapshot    = true
}
