#!/usr/bin/env bash

VERSION_STRING="5:20.10.6~3-0~ubuntu-focal"

# extends the sudo timeout for another 15 minutes
sudo -v

# uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

# update apt repo
sudo apt update

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# add docker's officical GPG keys
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# set it to stable
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# install docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# list all available repo
# apt-cache madison docker-ce

# install specific version of docker
#sudo apt-get install -y docker-ce=${VERSION_STRING} docker-ce-cli=${VERSION_STRING} containerd.io

# verify docker
sudo docker run hello-world

# add current user to docker group
sudo groupadd docker
sudo usermod -aG docker ${USER}
sudo chmod 666 /var/run/docker.sock

# verify user
docker run hello-world

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# test the installation
docker-compose --version

