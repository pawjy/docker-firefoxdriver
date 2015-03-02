FROM debian:sid

RUN apt-get update && apt-get install -y wget bzip2 unzip xvfb openjdk-7-jre fonts-noto && rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate https://www.google.com/get/noto/pkgs/NotoSansCJKJP-hinted.zip && \
    unzip NotoSansCJKJP-hinted.zip && \
    mkdir -p usr/share/fonts/truetype/noto && \
    mv *.otf usr/share/fonts/truetype/noto/ && \
    fc-cache && \
    rm NotoSansCJKJP-hinted.zip

## <http://www.seleniumhq.org/download/>
#RUN wget http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar
RUN wget `wget -O - https://raw.githubusercontent.com/wakaba/docker-firefoxdriver/master/stable/selenium-url`

RUN wget -m -np https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/ && \
    tar jvxf /ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/firefox-*.tar.bz2 && \
    rm -fr /ftp.mozilla.org

RUN echo "#!/bin/bash" > /runfx && \
    echo 'DISPLAY=:0 /firefox/firefox "$*"' >> /runfx && \
    chmod u+x /runfx

RUN echo "#!/bin/bash" > /fx && \
    echo 'Xvfb :0 -screen 0 1024x768x24 &' >> /fx && \
    echo 'java -jar selenium-server-standalone-*.jar -port 9516 -Dwebdriver.firefox.bin=/runfx' >> /fx && \
    chmod u+x /fx

RUN echo "#!/bin/bash" > /fx-port && \
    echo 'Xvfb :0 -screen 0 1024x768x24 &' >> /fx-port && \
    echo 'java -jar selenium-server-standalone-*.jar -port $1 -Dwebdriver.firefox.bin=/runfx' >> /fx-port && \
    chmod u+x /fx-port
