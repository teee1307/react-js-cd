#!/bin/bash 
set -e  
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get -y install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get -y install docker-ce 
sudo apt-get -y docker-ce-cli 
sudo apt-get -y containerd.io 
sudo apt-get -y docker-buildx-plugin 
sudo apt-get -y docker-compose-plugin

sudo docker run hello-world  

#----------------------------------------------------------------------




# Update package lists
sudo apt-get update

# Install required packages
sudo apt-get install -y ruby wget

# Download and install CodeDeploy agent
cd /home/ubuntu
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto

# Start CodeDeploy agent service
sudo systemctl start codedeploy-agent

# Check status of CodeDeploy agent service
sudo systemctl status codedeploy-agent
