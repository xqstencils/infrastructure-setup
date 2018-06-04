#!/bin/sh

basedir="$(cd $(dirname $0) && pwd)"
rootdir="$(cd ${basedir}/../ && pwd)"

service_name="nginx"

echo "Restart service..."
container_id=$(docker ps -a -q -f name=${service_name})
echo "Will stop & rm container [${container_id}]"
docker stop ${container_id} && docker rm ${container_id}

echo "Starting ..."
docker run -d \
 --restart=always \
 --name=${service_name} \
 -v ${rootdir}/auth:/auth:ro \
 -v ${rootdir}/certs:/certs:ro \
 -v ${rootdir}/config:/etc/nginx:ro \
 -v ${rootdir}/data/www:/data/www:ro \
 -p 80:80 \
 -p 443:443 \
 nginx:1.14-alpine

echo "Service already started"
