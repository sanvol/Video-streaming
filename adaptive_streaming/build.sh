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

# CONFIGS
IMAGE=adaptive_streaming
NAME=nginx-rtmp
DASH_VOLUME=dash_volume
HLS_VOLUME=hls_volume

docker volume create $DASH_VOLUME > /dev/null
docker volume create $HLS_VOLUME > /dev/null

while true; do
    # For static content:
    # CONTENT=../dist
    # --mount source=$CONTENT,target=/usr/local/nginx/html/
    if docker build -t $IMAGE . && \
        docker run -p 8080:8080 -p 1935:1935 \
        --mount source=$DASH_VOLUME,target=/var/lib/dash \
        --mount source=$HLS_VOLUME,target=/var/lib/hls \
        -d $IMAGE ; then
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
