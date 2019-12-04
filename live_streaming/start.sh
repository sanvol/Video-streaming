#!/bin/bash
TAG=live_streaming

cwd=$(pwd)
cd $(dirname $0)
docker build -t $TAG . && docker run -p 8080:8080 -p 1935:1935 $TAG
cd $cwd
