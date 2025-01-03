resource "aws_key_pair" "appconfig_key" {
  key_name   = "my-key-pair"
  public_key = file("/Users/dchathuran/.ssh/my-key-pair.pub")
}

resource "aws_instance" "appconfig_instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.appconfig_key.key_name

  security_groups = [aws_security_group.appconfig_sg.name]

  user_data = templatefile("userdata.sh", {
    APP_ID         = module.appconfig.application_id
    PROFILE_ID     = module.appconfig.profile_id
    CONFIG_VERSION = module.appconfig.configuration_version
    ENV_ID         = module.appconfig.environment_id
  })

  tags = {
    Name = "AppConfigAgent"
  }

  root_block_device {
    volume_size = 80
    volume_type = "gp2"
  }
}

resource "aws_ebs_volume" "appconfig_volume" {
  availability_zone = aws_instance.appconfig_instance.availability_zone
  size              = 8

  tags = {
    Name = "AppConfigRootVolume"
  }
}

resource "aws_ebs_snapshot" "appconfig_snapshot" {
  depends_on = [aws_ebs_volume.appconfig_volume]

  volume_id   = aws_ebs_volume.appconfig_volume.id
  description = "Snapshot of appconfig EC2 instance root volume"
}

resource "aws_ami" "appconfig_ami" {
  depends_on = [aws_ebs_snapshot.appconfig_snapshot]

  name                = "appconfig-ami"
  description         = "AMI created from the appconfig EC2 instance"
  virtualization_type = "hvm"
  root_device_name    = "/dev/sda1"

  ebs_block_device {
    device_name          = "/dev/sda1"
    snapshot_id          = aws_ebs_snapshot.appconfig_snapshot.id
    delete_on_termination = true
  }

  tags = {
    Name = "AppConfigAMI"
  }
}