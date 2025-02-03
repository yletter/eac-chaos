# Create a Security Group for Aurora
resource "aws_security_group" "aurora_sg" {
  name        = "aurora-mysql-sg"
  description = "Allow MySQL inbound traffic"

  vpc_id      = module.vpc.vpc_id
  
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your IP to allow access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a Subnet Group
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = module.vpc.private_subnets  # Replace with your subnet IDs
}

# Create an Aurora MySQL Cluster (Single Writer Instance)
resource "aws_db_instance" "chaos_db" {
  engine                 = "mysql"
  db_name                = "chaosdatabase"
  identifier             = "chaosdatabase"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  publicly_accessible    = true
  username               = "adminuser"
  password               = "Sunday!20250202"
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]
  skip_final_snapshot    = true
}

output "aurora_endpoint" {
  value = aws_db_instance.chaos_db.endpoint
}
