# Output the CI Server Public IP Address
output "ci_server_public_ip"
{
  value = "${aws_eip.ci_server_eip.public_ip}"
}

# Output CI Server URL
output "ci_server_url_local" {
  value = "${var.ci_server_url}"
}
