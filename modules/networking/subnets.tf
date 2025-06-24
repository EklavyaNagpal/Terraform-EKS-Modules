#This file contains the details of Subnets that will be used for VPC created for EKS

resource "aws_subnet" "public" {
  count = length(var.availability_zones)        #Count total number of Az's from main.tf(root) file 
  vpc_id = aws_vpc.eks-vpc.id
  cidr_block = cidrsubnet(var.cidr_range, 2, count.index)   #(Create CidrSubnet from defined CIDR Range, 2- NEWBITS, count.index is netnum) (base_cidr, newbits, netnum)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.name}-public-subnet-${count.index}"
  }
    
  }


resource "aws_subnet" "private" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.eks-vpc.id
  cidr_block = cidrsubnet(var.cidr_range, 4, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.name}-private-subnet-${count.index}"
  }
    
  }