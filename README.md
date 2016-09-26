# docker sonarr

Dockerfile to set up "sonarr" - (https://sonarr.tv/)

docker run \
    --restart=always \ 
    -d \
    -h *your_host_name* \
    -v /*your_config_location*:/config  \
    -v /*your_videos_location*:/data\
     -p 8989:8989 \
     timhaak/sonarr-alpine
     
Then open http://<server>:8989/

If you would like to build the image yourself

Build from docker file

```
git clone git@github.com:timhaak/docker-sonarr-alpine.git
cd docker-sonarr-alpine
docker build --pull --rm -t timhaak/sonarr-alpine .
```

