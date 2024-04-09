#! /bin/bash

echo "hi"

sudo hostnamectl set-hostname $(curl http://169.254.169.254/latest/meta-data/hostname)

sudo apt-get update -y
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.12/cri-dockerd_0.3.12.3-0.ubuntu-jammy_amd64.deb

sudo dpkg -i cri-dockerd_0.3.12.3-0.ubuntu-jammy_amd64.deb 