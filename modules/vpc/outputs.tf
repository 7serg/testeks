output "availability_zones" {
  value = data.aws_availability_zones.available.names 
}

output "vpc_id" {
  value = aws_vpc.eks_test.id
}

output "public_subnet_ids" {
  value = [for pub_subnet in aws_subnet.public_subnets: pub_subnet.id]
}


# output "public_subnet_ids" {
#   value = toset([for pub_subnet in aws_subnet.public_subnets: pub_subnet.id])
# }

output "public_subnets" {
    value = {
        for k,v in aws_subnet.public_subnets : k => v.id
  }
}

output "eks_test_sg_id" {  
  value = aws_security_group.eks_test_sg.id
}
