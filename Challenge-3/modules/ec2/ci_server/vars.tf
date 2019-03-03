# Terraform State S3 Bucket
variable "tf_state_bucket_name" {
}

# Terraform State Key File
variable "tf_state_key_name" {
}

# Terraform S3 Bucket Region
variable "tf_state_s3_region" {
}

# Define AWS Region
variable "AWS_REGION" {
}

# AWS Profile selection using Workspace
variable "AWS_PROFILE" {
}

# Path to the public key to be attached to the EC2 instance
variable "PATH_TO_PUBLIC_KEY" {
  default = "ci-server-key.pub"
}

# Choose the AMI which you want to launch
# ami-4bfe6f33 - Debian Jessie
variable "ami" {
  type = "map"
  default =
  {
    ap-south-1 = "ami-02e60be79e78fef21"
  }
}

# CI Server URL
variable "ci_server_url" {
  default = "jenkins.equalexperts.com"
}
