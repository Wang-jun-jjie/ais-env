#!/usr/bin/env bash

# extends the sudo timeout for another 15 minutes
sudo -v

# add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
    sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
    sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt update

# install nvidia-doceker and restart docker
sudo apt install -y nvidia-docker2 nvidia-container-toolkit 
sudo systemctl restart docker
