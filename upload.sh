#!/bin/bash
SSH_TARGET=edill@box64-2.nsls2.bnl.gov
echo "
    Cleaning up conda-builds folder on edill@penelope
"
ssh -T $SSH_TARGET << "SSH"
rm -rf conda-builds
SSH

echo "
    Copying new builds to edill@penelope
"
scp -r ~/builds $SSH_TARGET:~/conda-builds

echo "
    Uploading tag builds to 
        $TAG_CHANNEL
    
    and dev builds to 
        $DEV_CHANNEL
    
    on anaconda.nsls2.bnl.gov
"
echo "
export REQUESTS_CA_BUNDLE=/etc/certificates/ca_cs_nsls2_local.crt
export no_proxy=cs.nsls2.local
export HTTP_PROXY=http://proxy:8888
export HTTPS_PROXY=http://proxy:8888

export BINSTAR_TOKEN=$BINSTAR_TOKEN
export TAG_CHANNEL=$TAG_CHANNEL
export DEV_CHANNEL=$DEV_CHANNEL
mkdir -p ~/.config/binstar
echo 'url: https://pergamon.cs.nsls2.local:8443/api' > ~/.config/binstar/config.yaml
env
/home/edill/miniconda/bin/anaconda -t $BINSTAR_TOKEN upload ~/conda-builds/tag/* -u $TAG_CHANNEL
/home/edill/miniconda/bin/anaconda -t $BINSTAR_TOKEN upload ~/conda-builds/dev/* -u $DEV_CHANNEL
" > remote_script.sh

ssh -T $SSH_TARGET 'bash -s' < remote_script.sh
