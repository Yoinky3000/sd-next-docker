#!/usr/bin/env bash

# Clone SD Next (master branch)
git clone https://github.com/vladmandic/automatic "SD Next"

# Pre install extensions
mkdir ./SD\ Next/extensions
cd ./SD\ Next/extensions
git clone https://github.com/DominikDoom/a1111-sd-webui-tagcomplete
git clone https://github.com/Bing-su/adetailer
git clone https://github.com/hako-mikan/sd-webui-regional-prompter
git clone https://github.com/hako-mikan/sd-webui-supermerger
git clone https://github.com/butaixianran/Stable-Diffusion-Webui-Prompt-Translator
git clone https://github.com/Coyote-A/ultimate-upscale-for-automatic1111

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
TORCH_COMMAND="torch==2.3.1 torchvision --index-url https://download.pytorch.org/whl/${DEFAULT_WHL}" \
    python3 ./sdnext-preinstall.py && \
rm ./sdnext-preinstall.py
rm -rf sdpi

deactivate