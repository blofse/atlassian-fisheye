#!/bin/bash

echo About to stop fisheye service
docker stop -t 2 atlassian-fisheye
systemctl stop docker-atlassian-fisheye

echo About to remove original docker container
docker rm atlassian-fisheye

echo About to rebuild image
docker build --no-cache=true -t atlassian-fisheye .

echo About to run image
docker run \
  --name atlassian-fisheye \
  -p 8060:8060 \
  -v atlassian-fisheye-serverconf:/opt/atlassian/fisheye \
  --net atlassian-fisheye-network \
  -d \
  atlassian-fisheye

echo About to sleep for 20 seconds while fisheye comes up
sleep 20

echo Awake

echo About to restart to be used by the systemctl service and pickup files
docker stop -t 2 atlassian-fisheye
systemctl start docker-atlassian-fisheye

echo Done!
