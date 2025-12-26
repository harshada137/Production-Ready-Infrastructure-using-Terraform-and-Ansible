resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private2.id
  ]

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.medium"
  db_name                 = "mydb"
  username             = "admin"
  password             = "MySecurePass123!"
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [
    aws_security_group.db_sg.id
  ]
  multi_az             = true
  publicly_accessible  = false
  skip_final_snapshot  = true

  tags = {
    Name = "prod-mysql-db"
  }
}
