#!/bin/bash

echo Stopping/removing services
systemctl stop docker-atlassian-fisheye-postgres
systemctl stop docker-atlassian-fisheye

systemctl disable docker-atlassian-fisheye-postgres
systemctl disable docker-atlassian-fisheye

if [ -f /etc/systemd/system/docker-atlassian-fisheye.service ]; then
  rm -fr /etc/systemd/system/docker-atlassian-fisheye.service
fi
if [ -f /etc/systemd/system/docker-atlassian-fisheye-postgres.service ]; then
  rm -fr /etc/systemd/system/docker-atlassian-fisheye-postgres.service
fi

systemctl daemon-reload

echo Kill/remove docker images
docker stop atlassian-fisheye-postgres || true && docker rm atlassian-fisheye-postgres || true
docker stop atlassian-fisheye || true && docker rm atlassian-fisheye || true

echo Removing volumes
docker volume rm atlassian-fisheye-postgres-data || true
docker volume rm atlassian-fisheye-home || true

echo Removing networks
docker network rm atlassian-fisheye-network || true

echo Removing docker image - fisheye only
# docker rmi atlassian-fisheye

echo Done!