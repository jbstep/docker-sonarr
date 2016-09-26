# Dockerfile for Sonarr

Dockerfile to set up [Sonarr](https://sonarr.tv/)

docker run \
    --restart=always \ 
    -d \
    -h *your_host_name* \
    -v /*your_config_location*:/config  \
    -v /*your_videos_location*:/data\
     -p 8989:8989 \
     jbstep/sonarr
     
Then open http://yourserver:8989/

If you would like to build the image yourself

Build from docker file

```
git clone git@github.com:jbstep/docker-sonarr.git
cd docker-sonarr
docker build --pull --rm -t jbstep/sonarr .
```

