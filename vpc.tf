##########################
# VPC
##########################
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "prod-vpc"
  }
}

##########################
# Internet Gateway
##########################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "prod-igw"
  }
}

##########################
# Public Subnet
##########################
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "prod-public-subnet"
  }
}

##########################
# Private Subnet 1
##########################
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "prod-private-subnet-1"
  }
}

##########################
# Private Subnet 2 (for Multi-AZ RDS)
##########################
resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-south-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "prod-private-subnet-2"
  }
}

##########################
# Public Route Table
##########################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "prod-public-rt"
  }
}

##########################
# Associate Public Subnet
##########################
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
