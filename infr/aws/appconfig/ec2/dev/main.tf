provider "aws" {
  region = var.region
}

module "appconfig" {
  source = "./appconfig"
  appconfig_application_name = "appconfigapp2"
  appconfig_profile_name     = "myprofile"
}