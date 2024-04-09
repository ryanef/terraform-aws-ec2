#! /bin/bash

echo "hi"

sudo hostnamectl set-hostname $(curl http://169.254.169.254/latest/meta-data/hostname)

sudo apt install docker.io -y


sudo systemctl enable docker

