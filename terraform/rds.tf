# Create a Security Group for Aurora
resource "aws_security_group" "chaos_sg" {
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
resource "aws_db_subnet_group" "chaos_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = module.vpc.public_subnets  # Replace with your subnet IDs
}

# Create an Aurora MySQL Cluster (Single Writer Instance)
resource "aws_db_instance" "chaos_db" {
  engine                 = "mysql"
  engine_version         = "8.0.33"
  db_name                = "chaosdatabase"
  identifier             = "chaosdatabase"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  publicly_accessible    = true
  username               = "adminuser"
  password               = "Sunday!20250202"
  skip_final_snapshot    = true
  storage_type           = "gp2"
  vpc_security_group_ids = [aws_security_group.chaos_sg.id]  # Ensure this is in the same VPC
}

output "aurora_endpoint" {
  value = aws_db_instance.chaos_db.endpoint
}
