# nsls2-builder

Repository that holds the docker file for building binaries for the
conda packages needed by the Data Acquisition, Management and Analysis (DAMA)
group at NSLS-II.

Pushing to this repo will automatically trigger docker hub to create a new
docker image (or is it a container? I never can remember the terminology...).

This docker image is currently hosted at ericdill/debian79.

`docker pull ericdill/debian79`