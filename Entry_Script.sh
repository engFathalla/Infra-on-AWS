#!/bin/bash
sudo apt -y update && sudo apt install docker-ce
sudo systemctl start docker 
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
docker run --name=Nginx -p 8080:80 -d nginx:latest 