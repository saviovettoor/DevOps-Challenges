# Development VPC ID
output "development_vpc_id" {
    value = "${module.development_vpc.development_vpc_id_local}"
}

# Development VPC Public Subnet ID
output "development_vpc_public_subnet_id" {
  value = "${module.development_vpc.development_vpc_public_subnet_id_local}"
}

# Development VPC Private Subnet ID
output "development_vpc_private_subnet_id" {
  value = "${module.development_vpc.development_vpc_private_subnet_id_local}"
}

# NAT Gateway IP Address
output "development_vpc_ngw_ip_address" {
    value = "${module.development_vpc.development_vpc_ngw_ip_address}"
}

# CI Server Public IP Address
output "ci_server_public_ip_address" {
  value = "${module.ci_server.ci_server_public_ip}"
}

# CI Server Public URL
output "ci_server_url" {
  value = "${module.ci_server.ci_server_url_local}"
}
