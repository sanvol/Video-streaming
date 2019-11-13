#!/bin/bash

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

cd $(dirname $0)
# https://hub.docker.com/r/tiangolo/nginx-rtmp/dockerfile
IMAGE=tiangolo/nginx-rtmp
while true; do
    # For static content:
    # CONTENT=../dist
    # --mount source=$CONTENT,target=/usr/local/nginx/html/
    if docker run -d --name nginx-rtmp $IMAGE ; then
        echo "Container running"
        break;  
    elif confirm "Would you like to rebuild the image? [y/n]" ; then
        CONTAINER=$(docker ps | grep $IMAGE | awk {'print $1'})
        docker stop $CONTAINER >> /dev/null
        docker rm $CONTAINER >> /dev/null
        continue;
    else
        echo "Using old build"
        break;
    fi
done
cd - >> /dev/null
