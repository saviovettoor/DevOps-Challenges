# VPC Creation
resource "aws_vpc" "development_vpc" {
  cidr_block = "${var.VPC_CIDR}"
  instance_tenancy = "default"
  enable_classiclink = "false"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags {
      Name = "${lookup(var.VPC_TAG_NAME, terraform.workspace)}"
  }
}

# Public Subnet
resource "aws_subnet" "development_vpc_public_subnet" {
    vpc_id = "${aws_vpc.development_vpc.id}"
    cidr_block = "${var.PUBLIC_SUBNET_CIDR}"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.AWS_REGION}a"
    tags {
        Name = "${lookup(var.PUBLIC_SUBNET_TAG_NAME, terraform.workspace)}"
    }
}

# Private Subnet
resource "aws_subnet" "development_vpc_private_subnet" {
    vpc_id = "${aws_vpc.development_vpc.id}"
    cidr_block = "${var.PRIVATE_SUBNET_CIDR}"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.AWS_REGION}a"
    tags {
        Name = "${lookup(var.PRIVATE_SUBNET_TAG_NAME, terraform.workspace)}"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "development_vpc_igw" {
  vpc_id = "${aws_vpc.development_vpc.id}"
  tags {
      Name = "${lookup(var.IGW_TAG_NAME, terraform.workspace)}"
  }
}

# Elastic IP Address for NAT Gateway
resource "aws_eip" "development_vpc_ngw_eip" {
  vpc      = true
}

# NAT Gateway
resource "aws_nat_gateway" "development_vpc_ngw" {
  allocation_id = "${aws_eip.development_vpc_ngw_eip.id}"
  subnet_id     = "${aws_subnet.development_vpc_public_subnet.id}"
  tags {
      Name = "${lookup(var.NGW_TAG_NAME, terraform.workspace)}"
  }
}

# Public Route Tables
resource "aws_route_table" "development_vpc_public_route_table" {
  vpc_id = "${aws_vpc.development_vpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.development_vpc_igw.id}"
  }
  tags {
      Name = "${lookup(var.PUBLIC_ROUTE_TABLE_TAG_NAME, terraform.workspace)}"
  }
}

# Private Route Table
resource "aws_route_table" "development_vpc_private_route_table" {
  vpc_id = "${aws_vpc.development_vpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_nat_gateway.development_vpc_ngw.id}"
  }
  tags {
      Name = "${lookup(var.PRIVATE_ROUTE_TABLE_TAG_NAME, terraform.workspace)}"
  }
}

# Public Route Associations
resource "aws_route_table_association" "development_vpc_public_route_association" {
  subnet_id = "${aws_subnet.development_vpc_public_subnet.id}"
  route_table_id = "${aws_route_table.development_vpc_public_route_table.id}"
}

# Private Route Associations
resource "aws_route_table_association" "development_vpc_private_route_association" {
  subnet_id = "${aws_subnet.development_vpc_private_subnet.id}"
  route_table_id = "${aws_route_table.development_vpc_private_route_table.id}"
}