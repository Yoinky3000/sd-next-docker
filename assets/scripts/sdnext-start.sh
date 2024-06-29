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
        echo "Starting Cloudflared..."
        script -q -c "cloudflared tunnel --url http://localhost:3001" /dev/null | while read -r line; do
            url=$(echo "$line" | grep -Eo 'https://[^ >]+trycloudflare.com' | head -1)
            if [ -n "$url" ]; then
                echo "Cloudflared is ready, visit $url to access SD Next"
                break
            fi
        done
    fi
done