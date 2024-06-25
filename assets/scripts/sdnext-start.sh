#!/usr/bin/env bash

cd /workspace/SD\ Next

mkdir -p /workspace/logs
if [[ ${PYTORCH_NIGHTLY} ]]; then
    TORCH_COMMAND=$NIGHTLY_COMMAND
fi
echo "Starting SD Next..."
TORCH_COMMAND=$TORCH_COMMAND ./webui.sh --port 3001