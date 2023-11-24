
variable "ami_id" {
    description = "AMI ID to provision"
    type = string
    default = "ami-0669b163befffbdfc"
}


variable "instance_type" {
  description = "Instance type"
  type = string
  default = "t2.micro"
}

variable "sec_group_ids" {
  type = list(string)
}

variable "public_key" {

}

# variable "is_bastion" {
#     type = bool
#     description = "Launches bastion server if true"
#     default = false
# }

# variable "vpc_id" {

# }

variable "subnet_id" {
  
}

# variable "ingress_ports" {

# }