# Provisioning CI Server Instance in Development VPC
resource "aws_instance" "ci_server" {
  ami           = "${lookup(var.ami, var.AWS_REGION)}"
  instance_type = "t2.micro"
  disable_api_termination = "false"

  # Public Subnet
  subnet_id = "${data.terraform_remote_state.development_vpc.development_vpc_public_subnet_id}"

  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ci_server_security_group.id}"]

  # Public SSH key
  key_name = "${aws_key_pair.ci_server_key.key_name}"

  # Root volume to be attached to the instance
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = true
  }

  # User Data to Install Jenkins, Nginx and Ansible
  user_data = "${data.template_file.ci_server_user_data.rendered}"

  # Tag the instance
  tags {
    Name = "Equal_Experts_CI_Server"
  }

  # Tag the volume
  volume_tags {
    Name = "CI_Server"
  }
}