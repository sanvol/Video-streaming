# Adaptive on-demand video streaming

More detailed report with video data preparation included
- [Adaptive Streaming report](Adaptive_Streaming_report.pdf)

### Start the server

```bash
./build.sh  # May need to run as root if you're using linux
```

### Streaming with dash

http://0.0.0.0:8080/playerdash.html?mpd=http://0.0.0.0:8080/dash/video.mpd

### Streaming with hls

http://0.0.0.0:8080/playerhls.html?src=http://0.0.0.0:8080/hls/video.m3u8
