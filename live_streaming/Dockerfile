FROM tiangolo/nginx-rtmp

RUN apt update
RUN apt install -y ffmpeg

RUN mkdir -p /var/lib/stream/hls/
ADD server/ /etc/nginx/
ADD client/ /usr/share/nginx/html/
