FROM debian:sid

RUN apt-get update
RUN apt-get install -y wget bzip2 unzip xvfb openjdk-7-jre fonts-noto

RUN wget --no-check-certificate https://www.google.com/get/noto/pkgs/NotoSansCJKJP-hinted.zip
RUN unzip NotoSansCJKJP-hinted.zip
RUN mkdir -p usr/share/fonts/truetype/noto
RUN mv *.otf usr/share/fonts/truetype/noto/
RUN fc-cache

## <http://www.seleniumhq.org/download/>
RUN wget http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar

RUN wget -m -np https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/
RUN tar jvxf /ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/firefox-*.tar.bz2

RUN echo "#!/bin/bash" > /runfx
RUN echo 'DISPLAY=:0 /firefox/firefox "$*"' >> /runfx
RUN chmod u+x /runfx

RUN echo "#!/bin/bash" > /fx
RUN echo 'Xvfb :0 -screen 0 1024x768x24 &' >> /fx
RUN echo 'java -jar selenium-server-standalone-2.44.0.jar -port 9516 -Dwebdriver.firefox.bin=/runfx' >> /fx
RUN chmod u+x /fx

RUN echo "#!/bin/bash" > /fx-port
RUN echo 'Xvfb :0 -screen 0 1024x768x24 &' >> /fx-port
RUN echo 'java -jar selenium-server-standalone-2.44.0.jar -port $1 -Dwebdriver.firefox.bin=/runfx' >> /fx-port
RUN chmod u+x /fx-port
