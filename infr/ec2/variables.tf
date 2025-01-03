variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-12345678" # Replace with your preferred AMI ID
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "my-key-pair" # Replace with your SSH key pair name
}

variable "appconfig_application_name" {
  default = "appconfigapp"
}

variable "appconfig_profile_name" {
  default = "myprofile"
}