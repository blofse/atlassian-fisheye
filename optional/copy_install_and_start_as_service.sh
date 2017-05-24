#!/bin/sh

echo Stopping existing container
docker stop atlassian-fisheye-postgres
docker stop atlassian-fisheye

echo Copying and running service
yes | cp optional/docker-atlassian-fisheye-postgres.service /etc/systemd/system/.
yes | cp optional/docker-atlassian-fisheye.service /etc/systemd/system/.
systemctl daemon-reload

systemctl enable docker-atlassian-fisheye-postgres
systemctl enable docker-atlassian-fisheye

systemctl start docker-atlassian-fisheye-postgres
systemctl start docker-atlassian-fisheye
echo Done!
