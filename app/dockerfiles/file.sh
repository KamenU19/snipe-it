#! /bin/bash
sudo chown ubuntu:ubuntu /home/ubuntu/snipeit
sudo mv /tmp/docker-compose.yml /home/ubuntu/snipeit/docker-compose.yml
sudo mv /tmp/my_env_file /home/ubuntu/snipeit/my_env_file
cd /home/ubuntu/snipeit
sudo docker-compose down
echo "Waiting 30 seconds"
sleep 30s
sudo docker-compose up -d