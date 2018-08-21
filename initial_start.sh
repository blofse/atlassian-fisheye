#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Expecting one argument'
    exit 0
fi

docker network create \
  --driver bridge \
  atlassian-fisheye-network

docker run \
  --name atlassian-fisheye-postgres \
  -e POSTGRES_USER=fisheye \
  -e POSTGRES_PASSWORD="$1" \
  -v atlassian-fisheye-postgres-data:/var/lib/postgresql/data \
  --net atlassian-fisheye-network \
  -d \
  postgres:9.5.6-alpine

docker run \
  --name atlassian-fisheye \
  -p 8060:8060 \
  -v atlassian-fisheye-serverconf:/opt/atlassian/fisheye \
  --net atlassian-fisheye-network \
  -d \
  atlassian-fisheye
