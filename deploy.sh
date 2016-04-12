#!/bin/bash
docker build -t ericdill/debian-conda-builder debian-conda-builder/
docker build -t ericdill/nsls2-conda-builder nsls2-conda-builder

docker push ericdill/debian-conda-builder
docker push ericdill/nsls2-conda-builder
