# Find availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

locals  {
  az_names = data.aws_availability_zones.available.names
}

resource "aws_vpc" "eks_test" {
    cidr_block = var.vpc_cidr_block
    tags = {
        "Name" = var.vpc_name
    }  
}

resource "aws_internet_gateway" "eks_igw" {
    vpc_id = aws_vpc.eks_test.id
    tags = {
        "Name": "${var.vpc_name} IGW"
    }  
}

resource "aws_subnet" "public_subnets" {
    for_each = toset(var.public_subnets_cidr)
    vpc_id = aws_vpc.eks_test.id
    cidr_block = each.key
    availability_zone = local.az_names[index(var.public_subnets_cidr, each.key)]
    map_public_ip_on_launch = true
    tags = {
        "Name": "${var.vpc_name} public subnet-${index(var.public_subnets_cidr, each.key) + 1}"
    }   
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.eks_test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }
  tags = {
    Name = "Public RT for ${var.vpc_name}"
  }
  depends_on = [aws_internet_gateway.eks_igw]
}

resource "aws_route_table_association" "public_routes" {
  for_each = aws_subnet.public_subnets
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = each.value.id
}

resource "aws_security_group" "eks_test_sg" {
    description = "EKS_VPC_SG"
    vpc_id      = aws_vpc.eks_test.id
    dynamic "ingress" {
    for_each = var.ingress_ports
    content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-SG"
  }

}