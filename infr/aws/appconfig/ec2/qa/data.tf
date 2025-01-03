data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
}