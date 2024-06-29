#!/usr/bin/env bash

echo Updating apt...
apt update -y > /dev/null

echo Upgrading apt...
apt upgrade -y > /dev/null

echo Installing apt packages...
apt install -y git \
    python3.10 \
    pythonpy \
    python3.10-venv \
    python3-pip \
    curl \
    wget \
    aria2 \
    lsb-release \
    sudo > /dev/null

echo Setting up for cloudflared...
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflared.list

echo Installing cloudflared...
sudo apt update > /dev/null && sudo apt install -y cloudflared > /dev/null

echo Installing necessary python packages...
pip install jupyterlab "huggingface_hub[hf_transfer]" humanize > /dev/null