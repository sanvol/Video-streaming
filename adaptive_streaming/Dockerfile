FROM tiangolo/nginx-rtmp

RUN mkdir -p /var/lib/stream/dash/

ADD server/mime.types /etc/nginx/mime.types
ADD server/nginx.conf /etc/nginx/nginx.conf
ADD client/ /usr/share/nginx/html/
