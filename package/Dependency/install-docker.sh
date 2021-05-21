#!/usr/bin/env bash

# extends the sudo timeout for another 15 minutes
sudo -v

# update apt repo
sudo apt update

# install docker
sudo apt install -y docker.io

# start docker
sudo systemctl enable --now docker

# add current user to docker group
sudo usermod -aG docker ${USER}

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

