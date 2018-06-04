#!/bin/sh

basedir="$(cd $(dirname $0) && pwd)"
rootdir="$(cd ${basedir}/../ && pwd)"

echo "Stop & rm service..."
docker-compose down

echo "Starting ..."
docker-compose up -d

echo "Service already started"
