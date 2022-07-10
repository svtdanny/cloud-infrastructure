#!/bin/bash

#sudo yum update -y
#sudo yum -y install docker
#sudo service docker start
#sudo usermod -a -G docker ec2-user
#sudo chmod 666 /var/run/docker.sock
#docker version

docker pull redis
docker run -it -p 6379:6379 redis