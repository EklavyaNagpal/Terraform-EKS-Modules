#This file contains the outputs of vpc file.

output "name" {
  value = var.name
  description = "Name of VPC created for EKS"
}

output "cidr_range" {
  value = var.cidr_range
  description = "CIDR Range that is defined for VPC"
}

output "availability_zones" {
    value = var.availability_zones
    description = "List of Availability Zones for VPC"  
}
