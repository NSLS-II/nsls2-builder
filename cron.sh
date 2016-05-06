#!/bin/bash
BASE_IMAGE="ericdill/debian-conda-builder:latest"
echo "
    Pulling base docker image: $BASE_IMAGE
"
docker pull $BASE_IMAGE


GIT_REPO="https://github.com/nsls-ii/nsls2-builder"
CLONE_PATH='/tmp/$LOGNAME/nsls2-builder'
echo "
    Removing any previous repos
"
rm -rf $CLONE_PATH

echo "
    Cloning docker repo to build nsls2 conda builder image locally
    so that I can pick up the nsls2 certificate
"
git clone $GIT_REPO $CLONE_PATH
echo "
    Copying nsls2 certificate to be a sibling of the nsls2 conda builder
    dockerfile
"
DOCKERFILE_FOLDER=$CLONE_PATH/nsls2-conda-builder

cp ~/certificates/ca_cs_nsls2_local.crt $DOCKERFILE_FOLDER
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
