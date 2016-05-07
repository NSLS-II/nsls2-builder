#!/bin/bash

# cd to the users home directory
cd

# Need three environmental variables
: "${DEV_CHANNEL:?Need to set DEV_CHANNEL to the anaconda user to upload dev builds to}"
: "${TAG_CHANNEL:?Need to set TAG_CHANNEL to the anaconda user to upload dev builds to}"
#: "${BINSTAR_TOKEN:?Need to set BINSTAR_TOKEN so that conda packages can be uploaded}"

# conda build complains with recipes that contain "numpy x.x" if the CONDA_NPY
# environmental variable is not set
export CONDA_NPY=1.10

echo "

Building tagged recipes

"
conda config --add channels $TAG_CHANNEL --force
TAG_DIR="~/auto-build-tagged-recipes"
wget https://raw.githubusercontent.com/NSLS-II/auto-build-tagged-recipes/master/build-directive.yaml -O ~/tag-directive.yaml
build_from_yaml ~/tag-directive.yaml -u $TAG_CHANNEL --no-upload

TAG_LOCATION=/host/tag
BUILD_LOCATION=~/conda/conda-bld/linux-64
echo "
    Copying tagged builds from $BUILD_LOCATION to $TAG_LOCATION
"
rm -rf $TAG_LOCATION/*.bz2
cp $BUILD_LOCATION/* $TAG_LOCATION
rm -rf $BUILD_LOCATION/*.bz2


echo "

Building dev recipes

"
conda config --add channels $DEV_CHANNEL --force
wget https://raw.githubusercontent.com/NSLS-II/staged-recipes-dev/master/build-directive.yaml -O ~/dev-directive.yaml
build_from_yaml ~/dev-directive.yaml -u $TAG_CHANNEL --no-upload

DEV_LOCATION=/host/dev

rm -rf $DEV_LOCATION/*.bz2
cp $BUILD_LOCATION/* $DEV_LOCATION
rm -rf $BUILD_LOCATION/*.bz2

