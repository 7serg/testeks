variable "aws_region" {
    type = string
    default = "eu-central-1"  
}

variable "vpc_cidr_block" {
    type = string
    default = "10.0.0.0/16"
    description = "cidr block for VPC"  
}


variable "vpc_name" {
    type = string
    default = "TEST_EKS_VPC"
  
}


variable "public_subnets_cidr" {
  description = "Public subnets"
  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

variable "public_key" {
  
}

variable "ami_id" {
    description = "AMI ID to provision"
    type = string
    default = "ami-0669b163befffbdfc"
}

