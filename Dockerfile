FROM frolvlad/alpine-mono
MAINTAINER tim@haak.co

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

ENV MEDIAINFO_VERSION='0.7.87'

RUN apk -U upgrade && \
    apk -U add \
        ca-certificates \
        make \
        g++ gcc git \
        sqlite sqlite-libs \
        xz \
        unrar \
        wget \
        zlib zlib-dev && \
    cd / && \
\
    wget "https://mediaarea.net/download/binary/mediainfo/${MEDIAINFO_VERSION}/MediaInfo_CLI_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz" \
        -O "/MediaInfo_CLI_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz" && \
    wget "https://mediaarea.net/download/binary/libmediainfo0/${MEDIAINFO_VERSION}/MediaInfo_DLL_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz" \
        -O "/MediaInfo_DLL_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz" && \
    cd / && \
    tar xpf "/MediaInfo_CLI_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz" && \
    tar xpf "/MediaInfo_DLL_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz" && \
\
    wget https://update.sonarr.tv/v2/master/mono/NzbDrone.master.tar.gz \
            -O /NzbDrone.master.tar.gz && \
    cd / && \
    tar xzvf /NzbDrone.master.tar.gz && \
\
    cd /MediaInfo_CLI_GNU_FromSource && \
    ./CLI_Compile.sh && \
    cd /MediaInfo_CLI_GNU_FromSource/MediaInfo/Project/GNU/CLI/ && \
    make install && \
\
    cd /MediaInfo_DLL_GNU_FromSource && \
    ./SO_Compile.sh && \
    cd /MediaInfo_DLL_GNU_FromSource/MediaInfoLib/Project/GNU/Library && \
    make install && \
    cd /MediaInfo_DLL_GNU_FromSource/ZenLib/Project/GNU/Library && \
    make install && \
\
    adduser -h /sonarr -D sonarr && \
    mkdir /sonarr/.config && \
    mkdir /config && \
    ln -sf /root/.config /config && \
    chown -R sonarr: /NzbDrone /sonarr/.config /config && \
\
    apk del \
    make \
    g++ gcc git sqlite \
    wget && \
    rm -rf "/MediaInfo_CLI_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz" && \
    rm -rf "/MediaInfo_DLL_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz" && \
    rm -rf /MediaInfo_CLI_GNU_FromSource && \
    rm -rf /MediaInfo_DLL_GNU_FromSource && \
    rm -rf /NzbDrone.master.tar.gz && \
    rm -rf /tmp && \
    rm -rf /var/cache/apk/*

VOLUME ["/config", "/data"]

EXPOSE 8989

ADD ./start.sh /start.sh

RUN chmod u+x /start.sh
#USER sonarr

CMD ["/start.sh"]
