#!/usr/bin/env bash

cd /workspace/SD\ Next

mkdir -p /workspace/logs
if [[ ${PYTORCH_NIGHTLY} ]]; then
    export TORCH_COMMAND="${NIGHTLY_COMMAND}"
fi
echo "Starting SD Next..."
./webui.sh --port 3001