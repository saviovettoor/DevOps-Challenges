# Red the terraform state to get the VPC ID
data "terraform_remote_state" "development_vpc" {
  workspace = "${var.AWS_PROFILE}"
  backend = "s3"
  config {
    bucket = "${var.tf_state_bucket_name}"
    key    = "${var.tf_state_key_name}"
    region = "${var.tf_state_s3_region}"
  }
}

 # User data script
  data "template_file" "ci_server_user_data" {
    template = "${file("${path.module}/ci_server_bootstrap.sh")}"
  }