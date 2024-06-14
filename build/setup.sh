#!/usr/bin/env bash

apt update -y
apt upgrade -y
apt install -y git \
    python3.10 \
    pythonpy \
    python3.10-venv \
    python3-pip \
    curl \
    wget

pip install jupyterlab