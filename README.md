# mkv-muxing-batch-gui-docker

mkv-muxing-batch-gui docker image

around 3GB after build, so be warned

## Features



## Prerequisites

- Docker

## Configuration



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
docker run ghcr.io/captmicr0/mkv-muxing-batch-gui-docker:latest
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
