#!/bin/bash
TARGET=debian-conda-builder
rm -rf $TARGET/conda-build-all
rm -rf $TARGET/conda-build-utils
git clone https://github.com/ericdill/conda-build-utils $TARGET/conda-build-utils

docker build -t ericdill/debian-conda-builder $TARGET

docker build -t ericdill/nsls2-conda-builder nsls2-conda-builder
