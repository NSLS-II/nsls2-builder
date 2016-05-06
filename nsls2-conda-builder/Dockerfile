FROM ericdill/debian-conda-builder:latest

MAINTAINER Eric Dill <edill@bnl.gov>

USER root
# add the nsls2 condarc
ADD .condarc /home/builder/.condarc
ADD edill.anaconda.nsls2.token /home/builder/binstar_token
RUN chown -R builder:builder /home/builder/
USER builder

RUN cat ~/.condarc

# add the certificate. Note that this has to be built on a machine where
# the certificate exists...
ADD ca_cs_nsls2_local.crt /certs/ca_cs_nsls2_local.crt

# set up the binstar api url
RUN mkdir -p ~/.config/binstar && \
    echo 'url: https://pergamon.cs.nsls2.local:8443/api' > ~/.config/binstar/config.yaml

# add environmental variables to the docker container
ENV REQUESTS_CA_BUNDLE /certs/ca_cs_nsls2_local.crt
ENV no_proxy cs.nsls2.local
ENV HTTP_PROXY http://proxy:8888
ENV HTTPS_PROXY http://proxy:8888

CMD ["sh", "-c", "conda info"]
