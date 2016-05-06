#!/bin/bash
BASE_IMAGE="ericdill/debian-conda-builder:latest"
echo "
    Pulling base docker image: $BASE_IMAGE
"
docker pull $BASE_IMAGE
GIT_REPO='.'

DOCKERFILE_FOLDER=$GIT_REPO/nsls2-conda-builder

echo "
    Download the source repos
"
CLONE_BASE=/tmp/$LOGNAME/debian-conda-builder
rm -rf $CLONE_BASE
mkdir -p $CLONE_BASE
cd $CLONE_BASE
git clone https://github.com/nsls-ii/staged-recipes-dev
git clone https://github.com/nsls-ii/auto-build-tagged-recipes
git clone https://github.com/nsls-ii/skbeam-recipes

echo "
    Copying nsls2 certificate to be a sibling of the nsls2 conda builder
    dockerfile
"
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
docker run \
    -e BINSTAR_TOKEN=$BINSTAR_TOKEN \
    -e DEV_CHANNEL=nsls2-dev-testing \
    -e TAG_CHANNEL=nsls2-tag-testing \
    $NSLS2_IMAGE:latest
