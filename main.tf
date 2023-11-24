module "vpc" {
    source = "./modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    public_subnets_cidr = var.public_subnets_cidr
    vpc_name = var.vpc_name 
}

module "kubectl_instance" {
    source = "./modules/kubectl"
    public_key = var.public_key
    ami_id = var.ami_id
    subnet_id = module.vpc.public_subnets[var.public_subnets_cidr[0]]
    sec_group_ids = [module.vpc.eks_test_sg_id]
}


module "eks" {
  source     = "./modules/eks"
  public_subnets_ids = module.vpc.public_subnet_ids
  vpc_id = module.vpc.vpc_id
  ssh_key_name = module.kubectl_instance.ssh_key_name
#   sg_ids     = module.sgs.security_group_public
#   vpc_id     = aws_vpc.kubectl-vpc.id
#   subnet_ids = [aws_subnet.kubectl_subnet-1.id, aws_subnet.kubectl_subnet-2.id]
}

# resource "aws_key_pair" "test_ssh_key" {
#     key_name = "testing-ssh-key"
#     public_key = file(var.public_key)
# }

# resource "aws_instance" "kubectl-server" {
#     ami = var.ami_id
#     instance_type = var.instance_type
#     subnet_id = var.subnet_id
#     key_name = aws_key_pair.test_ssh_key.key_name
#     associate_public_ip_address = true
#     vpc_security_group_ids = [var.sec_group_ids]
#     tags = {
#         "Name" = "Bastion host"
#     }
# }