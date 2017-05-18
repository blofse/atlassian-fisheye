#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Expecting one argument'
    exit 0
fi

docker run --name atlassian-fisheye-postgres -e POSTGRES_USER=fisheye -e POSTGRES_PASSWORD="$1" -v FisheyePostgresData:/var/lib/postgresql/data -d postgres:9.5.6-alpine
docker run -d --name atlassian-fisheye --link atlassian-fisheye-postgres:pgfisheye -p 8060:8060 -v FisheyeHomeVolume:/var/atlassian/application-data/fisheye atlassian-fisheye
