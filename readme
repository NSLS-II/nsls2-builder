# Usage

## Build the nsls2 stack outside of the nsls2 firewall

From the root of this git repository:

Build the docker image

```
docker build -t <your_docker_username>/debian-conda-builder debian-conda-builder/
```

e.g.,

```
docker build -t ericdill/debian-conda-builder debian-conda-builder/
```

Run the docker image. Note that you need to set three environmental variables.

`BINSTAR_TOKEN` : the binstar token that will authenticate you to anaconda.org so you can upload packages

`DEV_CHANNEL` : the anaconda.org username to upload dev builds (master branch builds)

`TAG_CHANNEL` ; the anaconda.org username to uplaod tag builds

```
docker run -e BINSTAR_TOKEN=<your_anaconda.org_token> -e DEV_CHANNEL=lightsource2-dev -e TAG_CHANNEL=lightsource2-tag ericdill/debian-conda-builder:latest
```

The above command *should* build the entire stack. Note that this takes ~60 minutes on my i7 laptop.


# Settings that are required for builds behind the nsls2 firewall

## WIP: Instructions to build for the anaconda server on the BNL campus network.

## Environmental Variables

Note that these are set in the Dockerfile located in nsls2-conda-builder/

- HTTPS_PROXY
- HTTP_PROXY
- noproxy
- REQUESTS_CA_BUNDLE

You need the nsls2 local certificate that is located on a number of the nsls2
machines on the controls network or you cannot upload to anaconda.nsls2.bnl.gov.
For this reason you need to build the nsls2-conda-builder image on a machine
that has the nsls2 local certificate. This is usually located in
/etc/certificates/ca_cs_nsls2_local.crt, but will need to be copied to your home
directory, as docker typically is not run with sufficient permissions that it can
copy from /etc/certificates.  The nsls2-conda-builder Dockerfile expects you to
have `ca_cs_nsls2_local.crt` in your home directory under the `certificates` folder.
So `~/certificates/ca_cs_nsls2_local.crt` is where you should have this file,
or the Dockerfile will not work. Other than that, you should just be able to do:

```
docker build -t <your_username>/nsls2-conda-builder nsls2-conda-builder/
```

e.g.,

```
docker build -t ericdill/nsls2-conda-builder nsls2-conda-builder/
```

and then run it:

```
docker run -e BINSTAR_TOKEN=<your_anaconda.nsls2.bnl.gov_token> -e DEV_CHANNEL=lightsource2-dev -e TAG_CHANNEL=lightsource2-tag ericdill/nsls2-conda-builder:latest
```
