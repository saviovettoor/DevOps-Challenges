# key pair to be attached to the CI Server EC2 instance
resource "aws_key_pair" "ci_server_key" {
  key_name = "ci-server"
  public_key = "${file("${path.module}/${var.PATH_TO_PUBLIC_KEY}")}"
}