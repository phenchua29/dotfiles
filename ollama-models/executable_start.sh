#!/usr/bin/env bash
set -e

OLLAMA_HOST="${OLLAMA_HOST:-127.0.0.1}"
OLLAMA_PORT="${OLLAMA_PORT:-11434}"
MODEL_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! pgrep -x ollama > /dev/null 2>&1; then
    echo "Starting Ollama server on $OLLAMA_HOST:$OLLAMA_PORT..."
    ollama serve &
    sleep 2
fi

echo "Waiting for API..."
until curl -s "$OLLAMA_HOST:$OLLAMA_PORT/api/tags" > /dev/null 2>&1; do
    sleep 1
done

if ! ollama list 2>/dev/null | grep -q qwen3.5-gec; then
    echo "Creating qwen3.5-gec model..."
    ollama create qwen3.5-gec -f "$MODEL_DIR/Modelfile"
fi

echo "Ready at http://$OLLAMA_HOST:$OLLAMA_PORT"
