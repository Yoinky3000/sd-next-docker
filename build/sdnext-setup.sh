#!/usr/bin/env bash

# Clone SD Next (master branch)
git clone https://github.com/vladmandic/automatic "SD Next"

# Setup git
cd ./SD\ Next
git reset --hard ${SD_NEXT_COMMIT}
echo "Updating submodules..."
git submodule --quiet update --init --recursive
git submodule --quiet sync --recursive

# Create and activate venv
echo "Creating python venv..."
python3 -m venv venv
source ./venv/bin/activate

# Pre install all python dependencies
cp /sdnext-preinstall.py ./sdnext-preinstall.py
cp -rp /sdpi ./sdpi
export TORCH_COMMAND="torch==2.3.1 torchvision --index-url https://download.pytorch.org/whl/${DEFAULT_WHL}" && \
    python3 ./sdnext-preinstall.py && \
echo -e "\nInstallation completed, verifying..." && \
    python3 ./sdnext-preinstall.py > /dev/null
rm ./sdnext-preinstall.py
rm -rf sdpi

deactivate