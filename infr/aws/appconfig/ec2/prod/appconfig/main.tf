# Create Application for AppConfig
resource "aws_appconfig_application" "appconfig_application" {
  name = "appConfigAppProd"
}

# Create Configuration Profile
resource "aws_appconfig_configuration_profile" "appconfig_configuration_profile" {
  application_id = aws_appconfig_application.appconfig_application.id
  name = "myProfileProd"
  location_uri = "hosted"
}

# Create Environment for AppConfig
resource "aws_appconfig_environment" "appconfig_environment" {
  application_id = aws_appconfig_application.appconfig_application.id
  name = "prod"
}

# Create Hosted Configuration Version
resource "aws_appconfig_hosted_configuration_version" "hosted_config_version" {
  depends_on = [aws_appconfig_configuration_profile.appconfig_configuration_profile]

  application_id = aws_appconfig_application.appconfig_application.id
  configuration_profile_id = aws_appconfig_configuration_profile.appconfig_configuration_profile.configuration_profile_id
  content_type = "application/json"
  content = jsonencode({
    "config1" = "bjju",
    "config2" = "config_value2"
    "config3" = "hisd"
  })
}

# Deployment
resource "aws_appconfig_deployment" "config_deployment" {
  depends_on = [
    aws_appconfig_hosted_configuration_version.hosted_config_version,
    aws_appconfig_environment.appconfig_environment,
    aws_appconfig_configuration_profile.appconfig_configuration_profile
  ]
  application_id = aws_appconfig_application.appconfig_application.id
  environment_id = aws_appconfig_environment.appconfig_environment.environment_id
  configuration_profile_id = aws_appconfig_configuration_profile.appconfig_configuration_profile.configuration_profile_id
  configuration_version = aws_appconfig_hosted_configuration_version.hosted_config_version.version_number
  deployment_strategy_id = "AppConfig.AllAtOnce"
}