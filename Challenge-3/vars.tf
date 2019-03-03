# Define the AWS REGION in which Terraform has to act
# Equal Experts : Mumbai, India
variable "AWS_REGION" {
  default = {
    development = "ap-south-1"
  }
}

# Define the key name for the state to the stored
variable "terraform_state_key" {
  default = "terraform.tfstate"
}

# Environment Mapping to Workspaces
variable "workspace_to_environment_map" {
  type = "map"
  default = {
    development = "equalexperts.development"
  }
}

# S3 Bucket Name to Store the Terraform State
variable "terraform_state_s3_bucket" {
  type = "map"
  default = {
    development = "equalexperts.terraform.state"
  }
}