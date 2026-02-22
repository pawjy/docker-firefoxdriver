FROM quay.io/wakaba/base:stable

RUN apt-get update && \
    apt-get install -y wget xz-utils unzip xvfb fontconfig \
    fonts-noto fonts-liberation fonts-noto-cjk && \
    rm -rf /var/lib/apt/lists/*

# geckodriver <https://github.com/mozilla/geckodriver>
RUN version=`wget -O - https://raw.githubusercontent.com/manakai/data-web-impls/master/data/geckodriver-latest.txt` && \
    wget -np https://github.com/mozilla/geckodriver/releases/download/$version/geckodriver-$version-linux64.tar.gz && \
    tar xvf geckodriver-*-linux64.tar.gz && \
    rm geckodriver-*-linux64.tar.gz && \
    chmod u+x /geckodriver

# Firefox
# To install dependencies of Firefox, firefox package is installed and then be purged.
RUN (apt-get update || apt-get update) && \
    (apt-get -y --no-install-recommends install firefox-esr dbus || \
     apt-get -y --no-install-recommends install firefox-esr dbus) && \
    apt-get -y purge firefox-esr && \
    rm -rf /var/lib/apt/lists/* && \
    wget -m -nv -np https://ftp.mozilla.org/pub/firefox/releases/`wget -O - https://raw.githubusercontent.com/manakai/data-web-impls/master/data/firefox-latest.txt`/linux-x86_64/ja/ && \
    tar Jvxf /ftp.mozilla.org/pub/firefox/releases/*/linux-x86_64/ja/firefox-*.tar.xz && \
    rm -fr /ftp.mozilla.org

RUN echo "#!/bin/bash" > /fx && \
    echo 'hosts=${WD_ALLOW_HOSTS:-localhost}' >> /fx && \
    echo 'Xvfb :0 -screen 0 1024x768x24 &' >> /fx && \
    echo 'DISPLAY=:0 /geckodriver --host 0.0.0.0 --port 9516 --allow-hosts $hosts --binary /firefox/firefox' >> /fx && \
    chmod u+x /fx

RUN echo "#!/bin/bash" > /fx-port && \
    echo 'hosts=${WD_ALLOW_HOSTS:-localhost}' >> /fx-port && \
    echo 'Xvfb :0 -screen 0 1024x768x24 &' >> /fx-port && \
    echo 'DISPLAY=:0 /geckodriver --host 0.0.0.0 --port $1 --allow-hosts $hosts --binary /firefox/firefox' >> /fx-port && \
    chmod u+x /fx-port

CMD ["/fx"]
