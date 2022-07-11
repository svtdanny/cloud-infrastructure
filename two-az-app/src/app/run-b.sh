#!/bin/bash

sudo yum update -y
sudo yum -y install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chmod 666 /var/run/docker.sock
docker version

export DB_ADDR="172.16.80.5"

docker pull sivtsovdt/simple-go-redis-app
docker run -it -p 8080:8080 -e DB_ADDR=${DB_ADDR} sivtsovdt/simple-go-redis-app