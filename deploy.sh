#!/bin/bash

cd /home/ec2-user/devops-build/build

echo "Starting Docker containers"
docker-compose up -d

if [ $? -eq 0 ]; then
    echo "Docker containers started successfully"
else
    echo "Docker containers failed to start"
    exit 1
fi
