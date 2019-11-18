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

remove_container() {
    CONTAINER=$(docker ps | grep $1 | awk {'print $1'})
    docker stop $CONTAINER
    docker rm $CONTAINER
}

cd $(dirname $0)
# https://hub.docker.com/r/tiangolo/nginx-rtmp/dockerfile
IMAGE=adaptive_streaming
NAME=nginx-rtmp
while true; do
    # For static content:
    # CONTENT=../dist
    # --mount source=$CONTENT,target=/usr/local/nginx/html/
    if docker build -t $IMAGE . && docker run -p 8080:8080 -p 1935:1935 -d $IMAGE ; then
        echo "Container running"
        break;  
    elif confirm "Would you like to remove old image? [y/n]" ; then
        remove_container $IMAGE >> /dev/null
        continue;
    else
        echo "Using old build"
        break;
    fi
done
cd - >> /dev/null
