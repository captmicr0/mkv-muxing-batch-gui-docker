FROM jlesage/baseimage-gui:ubuntu-22.04-v4

ARG DEBIAN_FRONTEND=noninteractive

COPY mkvtoolnix.download.list /etc/apt/sources.list.d/mkvtoolnix.download.list

# Update, fix locale, install mkvtoolnix, build python 3.10.8, update pip/setuptools/wheel
RUN apt-get update && apt-get install -y apt-transport-https wget locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8 \
    && echo /usr/lib/x86_64-linux-gnu/ | tee /etc/ld.so.conf.d/usr-lib-x86_64-linux-gnu.conf \
    && echo /usr/local/lib | tee /etc/ld.so.conf.d/usr-local-lib.conf \
    && ldconfig \
    && wget -O /usr/share/keyrings/gpg-pub-moritzbunkus.gpg https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg \
    && apt-get update \
    && apt-get install -y libboost-all-dev libxkbcommon-x11-0 libpugixml1v5 libmatroska7 libxcb-cursor0 git mkvtoolnix \
    && cp `whereis libboost_filesystem.so | awk '{print($2)}'` /usr/lib/libboost_filesystem.so.1.71.0

WORKDIR /build
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev tk-dev \
    && wget https://www.python.org/ftp/python/3.10.8/Python-3.10.8.tgz \
    && tar xzf Python-3.10.8.tgz \
    && cd Python-3.10.8 \
    && ./configure --enable-shared --enable-ipv6 --enable-optimizations \
    && make -j install \
    && make clean \
    && cd / \
    && rm -rf /build \
    && python3 -m pip install --upgrade pip setuptools wheel \
    && rm -rf /root/.cache

# Copy files
COPY startapp.sh /startapp.sh

# Download mkv-muxing-batch-gui
WORKDIR /app
RUN git clone --depth 1 https://github.com/yaser01/mkv-muxing-batch-gui.git \
    && cd mkv-muxing-batch-gui \
    && pip install -r requirements.txt \
    && rm -rf /root/.cache \
    && set-cont-env APP_NAME "MKV Muxing Batch GUI" \
    && chmod +x /startapp.sh

LABEL org.opencontainers.image.source=https://github.com/captmicr0/mkv-muxing-batch-gui-docker

# Local build
# docker build -t captmicr0/mkv-muxing-batch-gui-docker:1.0.0 .
# docker run captmicr0/mkv-muxing-batch-gui-docker:1.0.0
