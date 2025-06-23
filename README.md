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

