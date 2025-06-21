This Repository is for EKS modules, deployment using Terraform Code.

I am using here AWS Profile.
To setup this we need to pass this, terraform init -var="aws_profile=Terraform"

S3 will configured before it take value from provider.
Here I am using AWS Profile and for that we need to export the profile:
1- export AWS_PROFILE="Name of Profile that is configured in aws configure --profile"
2- terraform init -reconfigure