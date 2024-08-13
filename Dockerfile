# Using Alpine 3.16, due to having python 3.10.* binaries in package repo
FROM jlesage/baseimage-gui:alpine-3.16-v4.6.3

# Copy files
COPY startapp.sh /startapp.sh

# Set app name, make startapp executable, and 
RUN set-cont-env APP_NAME "MKV Muxing Batch GUI" \
    && chmod +x /startapp.sh \
    # install major dependencies
    && add-pkg git mkvtoolnix python3 py3-pip \
    # update pip, setuptools, wheel
    #&& python3 -m pip install --upgrade pip setuptools wheel \
    # install requirements for program (this will install qt5 as a dependency)
    && apk add py3-pyside2 py3-psutil \
    && python3 -m pip install comtypes

# Download mkv-muxing-batch-gui
WORKDIR /app
RUN git clone https://github.com/yaser01/mkv-muxing-batch-gui.git \
    && cd mkv-muxing-batch-gui \
    && git checkout develop-pyside2

LABEL org.opencontainers.image.source=https://github.com/captmicr0/mkv-muxing-batch-gui-docker
