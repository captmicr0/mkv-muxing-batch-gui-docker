# mkv-muxing-batch-gui-docker

mkv-muxing-batch-gui but inside a docker image

Using jlesage/docker-baseimage-gui as the base, I created this to run in my media stack
to avoid having to transfer files to my desktop and then back to the NAS just to change
the default subtitle and audio tracks.

Originally based on the ubuntu-22.04 baseimage, it's been moved over the the alpine-3.16
baseimage, which reduced the image size from around 3GB to just 505MB!

Due to some compatibility issues with Qt6 and alpine, this container uses the [develop-pyside2](https://github.com/yaser01/mkv-muxing-batch-gui/tree/develop-pyside2)
branch of mkv-muxing-batch-gui. I'm not sure wether this is a actual issue, but when testing
the application it failed to launch using the main branch. This might be due to exec-ing into
the containers shell and trying to launch it, preventing the baseimage init scripts from running.

## Features

Change the default subtitle and audio tracks on your directly on your NAS with a nice GUI.
Plus anything else [mkv-muxing-batch-gui](https://github.com/yaser01/mkv-muxing-batch-gui) allows you to do.

## Configuration

Allow the container to access your media files by mapping any volumes you want.

## Docker container build

Local build:
```
git clone https://github.com/captmicr0/mkv-muxing-batch-gui-docker
cd mkv-muxing-batch-gui-docker
docker build -t captmicr0/mkv-muxing-batch-gui-docker:latest .
```

## Docker container usage

Command line:
```
docker run -p 4700:5800 -v /path/to/media/files:/data ghcr.io/captmicr0/mkv-muxing-batch-gui-docker:latest
```

Docker-Compose:
```
version: "3.7"
services:
  ###--- mkv-muxing-batch-gui ------------------------------------------------###
  mkv-muxing-batch-gui:
    image: ghcr.io/captmicr0/mkv-muxing-batch-gui-docker:latest
    container_name: mkv-muxing-batch-gui
    volumes:
      - /path/to/media/files:/data
      # TIMEZONE
      - /etc/localtime:/etc/localtime:ro
    ports:
     - 4700:5800
    restart: always
```
## Attribution

The application this container runs is [mkv-muxing-batch-gui](https://github.com/yaser01/mkv-muxing-batch-gui), big thanks to them for creating it!
The container is based on the [jlesage/docker-baseimage-gui container](https://github.com/jlesage/docker-baseimage-gui).
