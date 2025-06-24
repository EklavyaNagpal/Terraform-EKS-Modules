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

variable "destination_cidr_block" {
  type = string
  default = "0.0.0.0/0"
  description = "This defines the destination for a route in a route table. Any traffic going outside the VPC, route it to the Internet Gateway"
}
