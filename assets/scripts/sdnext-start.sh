#!/usr/bin/env bash

cd /workspace/SD\ Next

mkdir -p /workspace/logs
if [[ ${PYTORCH_NIGHTLY} ]]; then
    TORCH_COMMAND=$NIGHTLY_COMMAND
fi
echo "SD Next started, the terminal logs will be output to - /workspace/logs/sdnext.log"
echo "" > /workspace/logs/sdnext.log
TERM=dumb TORCH_COMMAND=$TORCH_COMMAND ./webui.sh --port 3001 2>/dev/null | while read -r line; do
    echo "$line" >> /workspace/logs/sdnext.log
    if [[ $line == *"localhost"* ]]; then
        echo "SD Next is ready"
    fi
done