#!/bin/bash
sudo yum update -y
sudo yum install -y aws-cli
sudo yum install -y jq
sudo yum install -y curl

# Configure AppConfig Agent
APP_ID="appconfigapp"
PROFILE_ID="myprofile"
CONFIG_VERSION="abc1234"
ENV_ID="dev"

echo "Deploying AWS AppConfig agent"
curl -o aws-appconfig-agent.zip https://github.com/aws/aws-appconfig-agent/releases/latest/download/aws-appconfig-agent.zip
unzip aws-appconfig-agent.zip
sudo ./aws-appconfig-agent --application-id $APP_ID --configuration-profile-id $PROFILE_ID --configuration-version $CONFIG_VERSION --environment-id $ENV_ID