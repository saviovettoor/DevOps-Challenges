# Define AWS Region
variable "AWS_REGION" {}

# Define the VPC CIDR for the Development VPC
variable "VPC_CIDR" {
  default = "172.20.0.0/16"
}

# Define the Public Subnet CIDR
variable "PUBLIC_SUBNET_CIDR" {
  default = "172.20.10.0/24"
}

# Define the Public Subnet CIDR
variable "PRIVATE_SUBNET_CIDR" {
  default = "172.20.20.0/24"
}

# VPC tag Name
variable "VPC_TAG_NAME" {
  type = "map"
  default = {
    development = "equalexperts.development.vpc"
  }
}

# Public Subnet Name
variable "PUBLIC_SUBNET_TAG_NAME" {
  type = "map"
  default = {
    development = "equalexperts.development.public.subnet"
  }
}

# Private Subnet Name
variable "PRIVATE_SUBNET_TAG_NAME" {
  type = "map"
  default = {
    development = "equalexperts.development.private.subnet"
  }
}

# Internet Gateway Tag Name
variable "IGW_TAG_NAME" {
  type = "map"
  default = {
    development = "equalexperts.development.igw"
  }
}

# NAT Gateway Tag Name
variable "NGW_TAG_NAME" {
  type = "map"
  default = {
    development = "equalexperts.development.ngw"
  }
}

# Public Route Table Tag Name
variable "PUBLIC_ROUTE_TABLE_TAG_NAME" {
  type = "map"
  default = {
    development = "equalexperts.development.public.route.table"
  }
}

# Private Route Table Tag Name
variable "PRIVATE_ROUTE_TABLE_TAG_NAME" {
  type = "map"
  default = {
    development = "equalexperts.development.private.route.table"
  }
}