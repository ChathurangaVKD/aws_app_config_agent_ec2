output "application_id" {
  value = aws_appconfig_application.appconfig_application.id
}

output "profile_id" {
  value = aws_appconfig_configuration_profile.appconfig_configuration_profile.id
}

output "environment_id" {
  value = aws_appconfig_environment.appconfig_environment.arn
}

output "configuration_version" {
  value = aws_appconfig_hosted_configuration_version.hosted_config_version.version_number
}

output "configuration_profile_id" {
  value = aws_appconfig_configuration_profile.appconfig_configuration_profile.id
}