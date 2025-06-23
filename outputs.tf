#This file will display the outputs for the variables declared.

output "provider_aws_region" {
  description = "AWS Region Value"
  value = var.provider_aws_region
}

output "profile_name" {
  description = "AWS Profile Name"
  value = var.profile_name
}

output "Environment" {
  description = "Environment Name"
  value = var.Environment
}