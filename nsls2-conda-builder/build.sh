#!/bin/bash

# cd to the users home directory
cd

# Need three environmental variables
: "${DEV_CHANNEL:?Need to set DEV_CHANNEL to the anaconda user to upload dev builds to}"
: "${TAG_CHANNEL:?Need to set TAG_CHANNEL to the anaconda user to upload dev builds to}"
: "${BINSTAR_TOKEN:?Need to set BINSTAR_TOKEN so that conda packages can be uploaded}"

# conda build complains with recipes that contain "numpy x.x" if the CONDA_NPY
# environmental variable is not set
export CONDA_NPY=1.10

echo "

Building tagged recipes

"
conda config --add channels $TAG_CHANNEL --force
YAML_FILE='~/auto-build-tagged-recipes/build-directive.yaml'
# replace the scikit-beam url with the local copy we downloaded
# in the docker file
sed -i 's/https:\/\/github.com\/scikit-beam\/skbeam-recipes/~\/skbeam-recipes/g' $YAML_FILE
# actually build it
build_from_yaml $YAML_FILE -u $TAG_CHANNEL

echo "

Building dev recipes

"
conda config --add channels $DEV_CHANNEL --force
build_from_yaml ~/staged-recipes-dev/build-directive.yaml -u $TAG_CHANNEL
