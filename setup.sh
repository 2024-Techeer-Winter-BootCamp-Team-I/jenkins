#!/bin/bash

# Update package list and install dependencies
sudo yum update -y
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# Add Docker repository
sudo amazon-linux-extras install docker

# Install Docker
sudo yum install -y docker

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add current user to the Docker group
sudo usermod -aG docker $USER

# Installation of Docker Compose
DOCKER_COMPOSE_VERSION=1.29.2
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
docker-compose --version

echo "Docker & Docker Compose Installation Complete."

# Add default 'ec2-user' to Docker group and reboot
sudo usermod -aG docker ec2-user

sudo reboot