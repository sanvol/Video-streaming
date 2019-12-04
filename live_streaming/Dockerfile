FROM tiangolo/nginx-rtmp

RUN mkdir -p /var/lib/stream/hls/

ADD server/ /etc/nginx/

ADD client/ /usr/share/nginx/html/
