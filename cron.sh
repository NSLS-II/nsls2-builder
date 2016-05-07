#!/bin/bash
DOCKER_IMAGE="ericdill/nsls2-conda-builder"
echo "
    Building nsls2 conda builder
"
docker build -t ericdill/nsls2-conda-builder nsls2-conda-builder

echo "
    Making scratch space on the host to store the built binaries
"
HOST_SCRATCH=~/builds
rm -rf $HOST_SCRATCH
mkdir -p $HOST_SCRATCH
DOCKER_IMAGE=$DOCKER_IMAGE:latest
echo "
    Starting $DOCKER_IMAGE which will build new binaries
"
docker run -t \
    -v $HOST_SCRATCH:/host \
    -e DEV_CHANNEL=$DEV_CHANNEL \
    -e TAG_CHANNEL=$TAG_CHANNEL \
    -e BINSTAR_TOKEN=$BINSTAR_TOKEN \
    $DOCKER_IMAGE
