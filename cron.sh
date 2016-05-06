#!/bin/bash
BASE_IMAGE="ericdill/debian-conda-builder:latest"
echo "
    Pulling base docker image: $BASE_IMAGE
"
docker pull $BASE_IMAGE
GIT_REPO='.'

echo "
    Copying nsls2 certificate to be a sibling of the nsls2 conda builder
    dockerfile
"
DOCKERFILE_FOLDER=$GIT_REPO/nsls2-conda-builder

cp ~/certificates/ca_cs_nsls2_local.crt $DOCKERFILE_FOLDER
cp ~/dev/dotfiles/tokens/edill.anaconda.nsls2.token $DOCKERFILE_FOLDER
NSLS2_IMAGE="ericdill/nsls2-conda-builder"

echo "
    Building nsls2-conda-builder docker image named $NSLS2_IMAGE
"
docker build -t $NSLS2_IMAGE $DOCKERFILE_FOLDER 


DEV_CHANNEL=nsls2-dev-testing
TAG_CHANNEL=nsls2-tag-testing
echo "
    Running docker image named $NSLS2_IMAGE with the following environmental 
    variables:

    BINSTAR_TOKEN=$BINSTAR_TOKEN
    DEV_CHANNEL=$DEV_CHANNEL
    TAG_CHANNEL=$TAG_CHANNEL
"
docker run -e BINSTAR_TOKEN=$BINSTAR_TOKEN -e DEV_CHANNEL=nsls2-dev-testing -e TAG_CHANNEL=nsls2-tag-testing $NSLS2_IMAGE:latest
