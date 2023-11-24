output "azs" {
  value = module.vpc.availability_zones 
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "eks_test_sg_id" {
  value = module.vpc.eks_test_sg_id
}

output "kubectl_server_ip" {
  value = module.kubectl_instance.kubectl_server_ip
}

output "ssh_key_name" {
    value = module.kubectl_instance.ssh_key_name
}

output "eks_endpoint" {
  value = module.eks.endpoint 
}
