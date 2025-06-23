#This file contains the information of Internet Gateway Resource

resource "aws_internet_gateway" "eks-ig" {
    vpc_id = aws_vpc.eks-vpc.id

    tags = {
      Terraform = true
      Environment = "Development"
      Name = "${var.name}-ig"
    }
  
}