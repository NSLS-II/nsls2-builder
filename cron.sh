#!/bin/bash
BASE_IMAGE="ericdill/debian-conda-builder:latest"
echo "
    Pulling base docker image: $BASE_IMAGE
"
docker pull $BASE_IMAGE


GIT_REPO="https://github.com/nsls-ii/nsls2-builder"
CLONE_PATH='/tmp/$LOGNAME/nsls2-builder'

echo "
    Cloning docker repo to build nsls2 conda builder image locally
    so that I can pick up the nsls2 certificate
"
git clone $GIT_REPO $CLONE_PATH

NSLS2_IMAGE="ericdill/nsls2-conda-builder"

echo "
    Building nsls2-conda-builder docker image
"
docker build -t $NSLS2_IMAGE $CLONE_PATH

docker run -e $BINSTAR_TOKEN -e DEV_CHANNEL nsls2-dev-testing -e TAG_CHANNEL -e nsls2-tag-testing $NSLS2_IMAGE:latest
