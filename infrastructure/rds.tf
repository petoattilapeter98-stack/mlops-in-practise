# VPC for RDS
resource "aws_vpc" "rds_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${local.project_name}-rds-vpc"
  }
}

# Subnets for RDS
resource "aws_subnet" "rds_subnet_1" {
  vpc_id            = aws_vpc.rds_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "${local.project_name}-rds-subnet-1"
  }
}

resource "aws_subnet" "rds_subnet_2" {
  vpc_id            = aws_vpc.rds_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "${local.project_name}-rds-subnet-2"
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${local.project_name}-rds-subnet-group"
  subnet_ids = [aws_subnet.rds_subnet_1.id, aws_subnet.rds_subnet_2.id]

  tags = {
    Name = "${local.project_name}-rds-subnet-group"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name   = "${local.project_name}-rds-sg"
  vpc_id = aws_vpc.rds_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # For simplicity, allow all; in production, restrict
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-rds-sg"
  }
}

# Massive RDS PostgreSQL Instance
resource "aws_db_instance" "postgres" {
  identifier             = "${local.project_name}-postgres"
  engine                 = "postgres"
  engine_version         = "16.1"
  instance_class         = "db.r6g.16xlarge"  # Massive instance: 64 vCPUs, 512 GB RAM
  allocated_storage      = 2000               # 2000 GB storage
  storage_type           = "gp3"
  iops                   = 12000              # High IOPS for gp3
  multi_az               = true               # Multi-AZ for higher availability and cost
  db_name                = "mlopsdb"
  username               = "mlopsuser"
  password               = "securepassword123"  # In production, use secrets manager
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  backup_retention_period = 30
  skip_final_snapshot    = true  # For testing, skip snapshot on destroy

  tags = {
    Name = "${local.project_name}-postgres"
  }
}
