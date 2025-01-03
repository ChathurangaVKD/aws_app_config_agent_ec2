output "instance_id" {
  value = aws_instance.appconfig_instance.id
}

output "instance_public_ip" {
  value = aws_instance.appconfig_instance.public_ip
}