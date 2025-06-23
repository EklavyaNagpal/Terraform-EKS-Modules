#Variables for VPC file

variable "name" {
  default = "eks"
  type = string
  description = "Name of VPC used for EKS"
}

variable "cidr_range" {
  default = "10.0.0.0/26"
  type = string
  description = "CIDR range for EKS VPC"
}

variable "availability_zones" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
  description = "Availability Zones for the VPC created for EKS "
}

# variable "public_subnets_eks" {
#   type = list(string)
#   default = [ "10.0.1.0/28", "10.0.2.0/28" ]
# }

# variable "private_subnets_eks" {
#   type = list(string)
#   default = [ "10.0.11.0/28", "10.0.12.0/28" ]
# }