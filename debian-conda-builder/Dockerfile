FROM debian:7.9

MAINTAINER Eric Dill <edill@bnl.gov>

RUN apt-get update && \
    apt-get install -y  \
      autoconf \
      build-essential \
      bzip2 \
      gcc \
      g++ \
      git \
      make \
      patch \
      tar \
      wget \
      zlib1g-dev \
      libreadline6-dev \
      libglib2.0-0 \
      libxext6 libxext-dev \
      libxrender1 libxrender-dev \
      libsm6 libsm-dev \
      tk-dev \
      libx11-6 libx11-dev \
      # gobject-introspection
      flex \
      # install extra packages for gobject-introspection package
      libffi-dev \
      libssl-dev \
      bison \
      # install packages for hkl
      gtk-doc-tools \
      # need an editor...
      vim \
      # and one for tom...
      emacs

# Set the Locale so conda doesn't freak out
# It is roughly this problem: http://stackoverflow.com/questions/14547631/python-locale-error-unsupported-locale-setting
# I don't remember exactly where I found this solution, but it took about 2 days of
# intense googling and trial-and-error
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && \
    apt-get install -y locales -qq && \
    locale-gen en_US.UTF-8 en_us && \
    dpkg-reconfigure locales && \
    dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

# Create the `builder` user
RUN useradd --create-home --shell /bin/bash builder

# Set the `builder` user as the active user so all ENV/RUN/ADD commands get run
# as the `builder` user
USER builder

# Add the conda binary folder to the builder's path
ENV PATH /home/builder/conda/bin:$PATH

# Actually install miniconda
RUN cd && \
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh --no-verbose && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p ~/conda && \
    rm Miniconda*.sh

# Install the minimum required packages for building conda packages
# - anaconda-client
# - conda-build
# - conda-build-all
# - conda-build-utils
RUN conda update conda && \
    conda install conda-build anaconda-client conda-build-all -c conda-forge && \
    conda remove conda-build-all --force && \
    conda clean -t -p

USER root

# Add the condarc that allows us to skip adding "--yes" to all the conda calls
# Also has the `nomkl` directive which significantly shortens the download times
# and always shows where the packages are downloaded from
ADD .condarc /home/builder/.condarc

# Add the build script so that it can be run when the docker container starts
ADD build.sh /home/builder/build.sh
ADD conda-build-utils/ /home/builder/conda-build-utils/
# Need to make sure builder owns these files
RUN chown -R builder:builder /home/builder

USER builder
# install conda-build-all and conda-build-utils
RUN pip install -e /home/builder/conda-build-utils
RUN cd && \
    git clone https://github.com/SciTools/conda-build-all && \
    pip install -e conda-build-all/ 

CMD ["/bin/bash", "/home/builder/build.sh"]
