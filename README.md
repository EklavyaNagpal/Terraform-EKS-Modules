This Repository is for EKS modules, deployment using Terraform Code.

I am using here AWS Profile.
To setup this we need to pass this, terraform init -var="aws_profile=Terraform"

S3 will configured before it take value from provider.
Here I am using AWS Profile and for that we need to export the profile:
1- export AWS_PROFILE="Name of Profile that is configured in aws configure --profile"
2- terraform init -reconfigure


📌 Your case:
hcl
Copy
Edit
cidrsubnet(var.cidr, 8, count.index)
Assuming:

var.cidr = "10.0.0.0/16"

8 means: add 8 bits to the /16 → results in subnets of /24

count.index cycles through 0, 1, 2, etc. for each subnet

🧮 What happens?
Terraform will compute:

cidrsubnet("10.0.0.0/16", 8, 0) → 10.0.0.0/24

cidrsubnet("10.0.0.0/16", 8, 1) → 10.0.1.0/24

cidrsubnet("10.0.0.0/16", 8, 2) → 10.0.2.0/24

and so on...

Each resulting subnet has 256 IP addresses (because /24 = 32 - 24 = 8 host bits → 2⁸ = 256).



========================================================================================================

VPC & Networking Configuration (Terraform)
This section defines the foundational networking setup for deploying an EKS cluster on AWS using Terraform. It includes creation of a VPC, subnets, Internet Gateway, route table, and relevant associations.

🔶 VPC Definition

<!-- resource "aws_vpc" "eks-vpc" {
  cidr_block           = var.cidr_range
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
} -->
aws_vpc.eks-vpc: Creates a new Virtual Private Cloud (VPC).

cidr_block: The IP range for the VPC (e.g., 10.0.0.0/16), provided via variable cidr_range.

enable_dns_support: Enables internal DNS resolution in the VPC.

enable_dns_hostnames: Allows EC2 instances in the VPC to have DNS hostnames.

tags: Adds a custom name tag for identification.

🌍 Internet Gateway

<!-- resource "aws_internet_gateway" "eks-ig" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Terraform   = true
    Environment = "Development"
    Name        = "${var.name}-ig"
  }
} -->
aws_internet_gateway.eks-ig: Provisions an Internet Gateway.

vpc_id: Associates the gateway with the VPC.

tags: Useful metadata for identification and environment labeling.

🛣️ Route Table

<!-- resource "aws_route_table" "eks-rt" {
  vpc_id = aws_vpc.eks-vpc.id
} -->
Creates a route table for the VPC.

This table will be used to define how traffic is routed within the network.

🌐 Public Internet Access Route

<!-- resource "aws_route" "public-internet-access" {
  route_table_id         = aws_route_table.eks-rt.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.eks-ig.id
} -->
aws_route.public-internet-access: Adds a route to the internet.

route_table_id: Links the route to the route table.

destination_cidr_block: Usually set to "0.0.0.0/0" to route all outbound traffic.

gateway_id: Points to the Internet Gateway for outbound internet access.

🔗 Public Subnet Association to Route Table

<!-- resource "aws_route_table_association" "public-association" {
  route_table_id = aws_route_table.eks-rt.id
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
} -->
Associates each public subnet with the route table.

Uses count to loop over all public subnets.

Ensures each subnet uses the route table with internet access.

🌐 Public Subnets

<!-- resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = cidrsubnet(var.cidr_range, 2, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.name}-public-subnet-${count.index}"
  }
} -->
Provisions one public subnet per availability zone.

count: Number of subnets = number of AZs.

cidrsubnet(...): Dynamically splits the main VPC CIDR into smaller chunks.

2: Number of additional bits to use for subnetting (2^2 = 4 subnets).

count.index: Which subnet to assign based on index.

availability_zone: Spreads subnets across multiple zones.

Each subnet is tagged for easier tracking.

🔒 Private Subnets

<!-- resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = cidrsubnet(var.cidr_range, 4, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.name}-private-subnet-${count.index}"
  }
} -->
Similar to public subnets, but for private use (e.g., backend services).

cidrsubnet(..., 4, ...): Uses more bits (4) to create smaller private ranges.

Provides finer-grained subnet allocation than public ones.

Same availability zone distribution and tagging strategy.

✅ Summary for README
Creates a highly available VPC with multiple public and private subnets.

Internet access is provided to public subnets through a route table and internet gateway.

Uses Terraform’s count and cidrsubnet() functions for dynamic, reusable subnet creation.

Designed to support AWS EKS or other multi-AZ services.

========================================================================================================