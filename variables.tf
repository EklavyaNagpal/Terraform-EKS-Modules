#This file will contain the variables for the infrastructure

variable "provider_aws_region" {
  default = "us-east-1"
  type = string
  description = "Passing the region value for AWS Environment"
}

variable "Environment" {
  default = "Development"
  type = string
  description = "Passing the Environment value for AWS Development"
}

variable "profile_name" {
  default = "Terraform"
  type = string
  description = "This is the AWS configure profile that is used to deploy infrastructure"
}

variable "availability_zones" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
  description = "Availability Zones for the VPC created for EKS "
}