#!/usr/bin/env bash

REPO_LINK="https://github.com/Wang-jun-jjie/ais-env"
INSTALL_PATH="/opt/ais-env"
MOTD_PATH="/etc/update-motd.d"
BIN_PATH="/usr/local/bin"

set -e -o pipefail

sudo -v

sudo timedatectl set-timezone Asia/Taipei

sudo git clone "${REPO_LINK}" "${INSTALL_PATH}"

cd ${INSTALL_PATH}/package
./Dependency/install-essential.sh
./Dependency/install-docker.sh

./NVIDIA/install-nv-driver.sh
./NVIDIA/install-cuda-cudnn.sh
./NVIDIA/install-nv-docker.sh

cd ${INSTALL_PATH}/script
for s in $(ls -A -I profile.d); do
  for ss in $(ls ${s}); do
    sudo ln -fns $(pwd)/${s}/${ss} ${BIN_PATH}/${ss}
  done
done
for ss in $(ls -A profile.d); do
  sudo ln -fns $(pwd)/profile.d/${ss} /etc/profile.d/${ss}
done

sudo chmod -x ${MOTD_PATH}/*
sudo chmod +x ${MOTD_PATH}/00-header
sudo chmod +x ${MOTD_PATH}/97-overlayroot
sudo chmod +x ${MOTD_PATH}/98-fsck-at-reboot
sudo chmod +x ${MOTD_PATH}/98-reboot-required

sudo ln -fns $(pwd)/motd/landscape-sysinfo ${MOTD_PATH}/50-landscape-sysinfo
sudo ln -fns $(pwd)/server_status/hdd-status ${MOTD_PATH}/51-hdd-status
sudo ln -fns $(pwd)/server_status/gpu-status ${MOTD_PATH}/52-gpu-status
