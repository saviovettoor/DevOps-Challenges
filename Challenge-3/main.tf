# Terraform state is stored in S3
# Bucket Name : equalexperts.terraform.state
# Path : s3://equalexperts.terraform.state/ --region ap-south-1
terraform {
  backend "s3" {
    bucket = "equalexperts.terraform.state"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

# Define Provider - AWS
provider "aws" {
   region = "${lookup(var.AWS_REGION, terraform.workspace)}"
   profile = "${var.workspace_to_environment_map[terraform.workspace]}"
}

# Module reference for provisioning the VPC
module "development_vpc" {
  source = "modules/vpc/development_vpc"
  AWS_REGION = "${lookup(var.AWS_REGION, terraform.workspace)}"
}

# Module reference for provisioning the CI Machine
module "ci_server" {
  source = "modules/ec2/ci_server"
  AWS_REGION = "${lookup(var.AWS_REGION, terraform.workspace)}"
  AWS_PROFILE = "${terraform.workspace}"
  tf_state_s3_region = "${lookup(var.AWS_REGION, terraform.workspace)}"
  tf_state_bucket_name = "${lookup(var.terraform_state_s3_bucket, terraform.workspace)}"
  tf_state_key_name = "${var.terraform_state_key}"
}