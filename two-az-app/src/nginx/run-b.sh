#!/bin/bash

sudo yum update -y
sudo yum -y install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chmod 666 /var/run/docker.sock
docker version

export APP_HOST="172.16.64.0"
export APP_PORT=8080

docker pull sivtsovdt/simple-nginx-test
docker run -it -p 8080:8080 -e APP_HOST=${APP_HOST} -e APP_PORT=${APP_PORT} sivtsovdt/simple-nginx-test
