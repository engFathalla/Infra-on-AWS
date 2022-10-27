#!/bin/bash
sudo yum -y update && sudo yum install docker
sudo systemctl start docker 
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
docker run --name=Nginx -p 8080:80 -d nginx:latest 