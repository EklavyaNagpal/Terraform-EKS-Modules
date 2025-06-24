#This file contains the route table component which is going to use for EKS VPC.

resource "aws_route_table" "eks-rt" {
  vpc_id = aws_vpc.eks-vpc.id
}

resource "aws_route" "public-internet-access" {
  route_table_id = aws_route_table.eks-rt.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id = aws_internet_gateway.eks-ig.id
}

resource "aws_route_table_association" "public-association" {
  route_table_id = aws_route_table.eks-rt.id
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
}