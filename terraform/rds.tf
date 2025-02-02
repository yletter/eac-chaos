# Create a Security Group for Aurora
resource "aws_security_group" "aurora_sg" {
  name        = "aurora-mysql-sg"
  description = "Allow MySQL inbound traffic"
  
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
  subnet_ids = [module.vpc.aws_subnet.private[0].id, module.vpc.aws_subnet.private[1].id]  # Replace with your subnet IDs
}

# Create an Aurora MySQL Cluster (Single Writer Instance)
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "aurora-mysql-cluster"
  engine                 = "aurora-mysql"
  engine_version         = "8.0.mysql_aurora.3.02.0"  # Check AWS for latest versions
  database_name          = "mydatabase"
  master_username        = "adminuser"
  master_password        = "Sunday!20250202"  # Store in Secrets Manager in production
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  skip_final_snapshot     = true
}

# Create a DB Instance within the Cluster
resource "aws_rds_cluster_instance" "aurora_instance" {
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.t3.micro"  # Cheapest option, not covered by Free Tier
  engine             = aws_rds_cluster.aurora_cluster.engine
}

output "aurora_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}
