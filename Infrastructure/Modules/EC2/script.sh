#! /bin/bash
sudo apt update -y 
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
sudo apt update -y
sudo apt-get install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo mkdir /root/snipe_it
sudo usermod -aG docker ubuntu
sudo apt install docker-compose -y
sudo mkdir /home/ubuntu/snipeit
sudo chown ubuntu:ubuntu /home/ubuntu/snipeit
cd /home/ubuntu/snipeit