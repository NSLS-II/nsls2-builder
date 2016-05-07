FROM ericdill/debian-conda-builder:latest

MAINTAINER Eric Dill <edill@bnl.gov>

USER root
# add the nsls2 condarc
ADD .condarc /home/builder/.condarc
ADD edill.anaconda.nsls2.token /home/builder/binstar_token
ADD build.sh /home/builder/build.sh
RUN chown -R builder:builder /home/builder/
USER builder

RUN cat ~/.condarc

# set up the binstar api url
RUN mkdir -p ~/.config/binstar && \
    echo 'url: https://anaconda.nsls2.bnl.gov/api' > ~/.config/binstar/config.yaml
