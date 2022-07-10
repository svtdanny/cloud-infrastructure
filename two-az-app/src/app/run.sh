#!/bin/bash

#sudo yum update -y
#sudo yum -y install docker
#sudo service docker start
#sudo usermod -a -G docker ec2-user
#sudo chmod 666 /var/run/docker.sock
#docker version

docker pull sivtsovdt/simple-go-redis-app
docker run -it -p 8080:8080 sivtsovdt/simple-go-redis-app