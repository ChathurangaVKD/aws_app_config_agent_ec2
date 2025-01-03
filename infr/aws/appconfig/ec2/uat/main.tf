provider "aws" {
  region = var.region
}

module "appconfig" {
  source = "./appconfig"
}