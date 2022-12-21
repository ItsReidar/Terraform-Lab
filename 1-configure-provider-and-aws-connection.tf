# Description: Configure the AWS Provider and AWS Connection
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# AWS connection (Windows)
provider "aws" {
  region = "eu-central-1"
  shared_config_files      = ["C:/Users/Reidar/.aws/config"]
  shared_credentials_files = ["C:/Users/Reidar/.aws/credentials"]
  profile                  = "Reidar"
}

# AWS connection (macOS)
# provider "aws" {
#   region = "eu-central-1"
#   shared_config_files      = ["$HOME/.aws/config"]
#   shared_credentials_files = ["$HOME/.aws/credentials"]
#   profile                  = "Reidar"
# }