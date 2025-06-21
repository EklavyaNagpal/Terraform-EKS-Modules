#This file initiate the backend for the terraform state file.
#Using S3 bucket to store the versioning and DynamoDB to prevent the locking of the state file.

terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "backend-terraform-eks-modules"
    key = "eks_backend/terraform.tfstate"
    dynamodb_table = "eks-terraform-lock-01"
    use_lockfile = true // This pararmeter is used because dynamodb_table is deprecated, still to use that we need to pass this parameter
  }
}