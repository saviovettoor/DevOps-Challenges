# Development VPC ID
output "development_vpc_id_local" {
  value = "${aws_vpc.development_vpc.id}"
}

# Development VPC Public Subnet ID
output "development_vpc_public_subnet_id_local" {
  value = "${aws_subnet.development_vpc_public_subnet.id}"
}

# Development VPC Private Subnet ID
output "development_vpc_private_subnet_id_local" {
  value = "${aws_subnet.development_vpc_private_subnet.id}"
}

# NAT Gateway IP Address
output "development_vpc_ngw_ip_address" {
    value = "${aws_eip.development_vpc_ngw_eip.public_ip}"
}