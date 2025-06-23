#This is the main file where we call all the modules.

module "networking" {
  source = "./modules/networking"
  availability_zones = var.availability_zones
}