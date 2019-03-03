# Security Group to be attached to the CI Server EC2 instance
resource "aws_security_group" "ci_server_security_group" {
  vpc_id = "${data.terraform_remote_state.development_vpc.development_vpc_id}"
  name = "ci-server-security-group"
  description = "security group that allows ssh, HTTP and HTTPS for ingress and all for egress traffic"
  # Allows all outgoing connections
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  # Allows 22/80/443 open to the entire world
  # Recommended to whitelist only specific IP adderss for SSH
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
      Name = "ci-server-security-group"
  }
}