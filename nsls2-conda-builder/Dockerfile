FROM ericdill/debian-conda-builder:latest

MAINTAINER Eric Dill <edill@bnl.gov>

# add the certificate
# ADD /env/certificates/ca_cs_nsls2_local.crt /
ADD condarc.nsls2 ~/.condarc

# add environmental variables to the docker container
ENV REQUESTS_CA_BUNDLE /ca_cs_nsls2_local.crt
ENV no_proxy cs.nsls2.local
ENV HTTP_PROXY http://proxy:8888
ENV HTTPS_PROXY http://proxy:8888

# set up the binstar api url
RUN mkdir -p ~/.config/binstar && \
    echo 'url: https://pergamon.cs.nsls2.local:8443/api' > ~/.config/binstar/config.yaml

# set up the condarc for nsls2
