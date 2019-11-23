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

container() {
    echo $(docker ps | grep $1 | awk {'print $1'})
}

remove_container() {
    CONTAINER=$(container $1)
    docker stop $CONTAINER
    docker rm $CONTAINER
}

cwd=$(pwd)
cd $(dirname $0)

IMAGE=adaptive_streaming
while true; do
    remove_container $IMAGE 2> /dev/null
    if docker build -t $IMAGE . && \
        docker run -p 8080:8080 -p 1935:1935 \
        -d $IMAGE ; then
        echo "Container running"

        sources=("dashvideo/." "hlsvideo/.")
        destinations=("/var/lib/stream/dash/" "/var/lib/stream/hls/")
        c=$(container $IMAGE)

        for i in "${!sources[@]}"; do
            src=${sources[$i]}
            dst=${destinations[$i]}
            if confirm "Do you want to copy files from $src to $c:$dst? [y/n]" ; then
                echo "Copying files"
                docker cp $src $c:$dst
            fi
        done

        break;
    elif confirm "An error occurred while building image. Would you like to try again? [y/n]" ; then
        continue;
    else
        echo "Build failed but retry was rejected. The current running containers are:"
        docker ps
        break;
    fi
done

cd $cwd
