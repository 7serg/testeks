terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
    backend "s3" {
    bucket = "terraform-state-artems-task"
    key    = "eks_test/infrastructure.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terraform-state-locking"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

