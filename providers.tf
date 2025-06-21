#This file is for the providers of Terraform. 

provider "aws" {
  region = var.provider_aws_region
  profile = var.profile_name //Passing profile name for AWS Profile which has been mapped using aws configure --profile

  default_tags {
    tags = {
        Environment = var.Environment
        Terraform = true
        Project = "EKS-Modules"
    }
  }
}