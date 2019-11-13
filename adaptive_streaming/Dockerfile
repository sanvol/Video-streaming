FROM tiangolo/nginx-rtmp

ENV DASH_SOURCE https://cdn.dashjs.org/latest/dash.all.min.js

ADD server/nginx.conf /etc/nginx/nginx.conf
ADD ${DASH_SOURCE} /usr/share/nginx/html
ADD client/index.html /usr/share/nginx/html
