# Live streaming

## Server

- run `./start.sh`

## Client

- Install [OBS](https://obsproject.com/)
- Add custom stream server
  - _rtmp://0.0.0.0:1935/hls_ if you're using hls
  - _rtmp://0.0.0.0:1935/live_ if you're using rtmp
    - **NOTE**
      - using rtmp requires flash
      - streaming client only works on the host machine (relative urls do not work)
- Use `stream` as the streaming key
- Once the server is up, you can start streaming
