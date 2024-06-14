#!/usr/bin/env bash

cd /

mkdir -p /workspace/logs

echo "Starting Jupyter Lab..."
nohup jupyter lab --allow-root \
    --no-browser \
    --port=3000 \
    --ip=* \
    --FileContentsManager.delete_to_trash=False \
    --ServerApp.terminado_settings='{"shell_command":["/bin/bash"]}' \
    --ServerApp.token=${JUPYTER_LAB_PASSWORD} \
    --ServerApp.allow_origin=* \
    --ServerApp.preferred_dir=/workspace &> /workspace/logs/jupyter.log &
echo "Jupyter Lab started, the terminal logs will be output to - /workspace/logs/jupyter.log"

sleep infinity