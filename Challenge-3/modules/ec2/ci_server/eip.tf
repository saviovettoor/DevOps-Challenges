# AWS Elastic IP to be attached to the CI Server Instance
resource "aws_eip" "ci_server_eip"
{
  instance = "${aws_instance.ci_server.id}"
  vpc = true
}