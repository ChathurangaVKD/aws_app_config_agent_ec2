provider "aws" {
  region = var.region
}

module "appconfig" {
  source = "./modules/appconfig"
  appconfig_application_name = "appconfigapp"
  appconfig_profile_name     = "myprofile"
}