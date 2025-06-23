resource "aws_vpc" "eks-vpc" {

  cidr_block = var.cidr_range
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
    # Terraform = true
    # Environment = "Development"
   }
}