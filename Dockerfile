# using alpine 3.16, due to having python 3.10.* binaries in package repo
FROM jlesage/baseimage-gui:alpine-3.16-v4.6.3

# install dependencies.
RUN add-pkg \
        openjdk8-jre-base \
        # For beta key fetching.
        wget \
        sed \
        # For the init script.
        findutils \
        # For the GUI.
        qt5-qtbase-x11 \
        adwaita-qt \
        font-croscore \
        # mkvtoolnix
        mkvtoolnix-gui \
        # python3.10.*, pip
        python3 py3-pip \
    # update pip, setuptools, wheel
    && python3 -m pip install --upgrade pip setuptools wheel

# Copy files
COPY startapp.sh /startapp.sh

# Download mkv-muxing-batch-gui
WORKDIR /app
RUN git clone --depth 1 https://github.com/yaser01/mkv-muxing-batch-gui.git \
    && cd mkv-muxing-batch-gui \
    && python3 -m pip install -r requirements.txt \
    && rm -rf /root/.cache \
    && set-cont-env APP_NAME "MKV Muxing Batch GUI" \
    && chmod +x /startapp.sh

LABEL org.opencontainers.image.source=https://github.com/captmicr0/mkv-muxing-batch-gui-docker
