#!/usr/bin/env bash

echo "========================================"
echo " Stable Diffusion A1111 WebUI Docker"
echo "========================================"
echo

if ! docker version >/dev/null 2>&1; then
    echo "[ERROR] Docker is not running. Please start Docker first."
    exit 1
fi

MODEL_DIR="data/models/Stable-diffusion"
HAS_MODEL=0

if ls "$MODEL_DIR"/*.safetensors 1>/dev/null 2>&1 || ls "$MODEL_DIR"/*.ckpt 1>/dev/null 2>&1; then
    HAS_MODEL=1
fi

if [ "$HAS_MODEL" -eq 0 ]; then
    echo "========================================"
    echo " No model found in $MODEL_DIR"
    echo "========================================"
    echo
    echo "  [Y] I will place my own model now"
    echo "  [N] Download SD 1.5 model automatically"
    echo
    read -p "Your choice (Y/N): " CHOICE

    if [[ "$CHOICE" =~ ^[Yy]$ ]]; then
        echo
        echo "Please place your model file in:"
        echo "  $(pwd)/$MODEL_DIR/"
        echo
        read -p "Press Enter when ready..."

        HAS_MODEL=0
        if ls "$MODEL_DIR"/*.safetensors 1>/dev/null 2>&1 || ls "$MODEL_DIR"/*.ckpt 1>/dev/null 2>&1; then
            HAS_MODEL=1
        fi

        if [ "$HAS_MODEL" -eq 0 ]; then
            echo
            echo "[ERROR] Still no model found. Exiting."
            exit 1
        fi
    else
        echo
        echo "Downloading SD 1.5 model..."
        echo
        docker compose --profile download run --rm download
        if [ $? -ne 0 ]; then
            echo "[ERROR] Download failed."
            exit 1
        fi
    fi
fi

if ! docker image inspect sd-auto:78 >/dev/null 2>&1; then
    echo
    echo "Building Docker image... This may take 10-20 minutes."
    echo
    docker compose --profile auto build
    if [ $? -ne 0 ]; then
        echo "[ERROR] Build failed."
        exit 1
    fi
fi

echo
echo "Stopping existing container..."
docker compose --profile auto down 2>/dev/null

echo
echo "========================================"
echo " Starting WebUI..."
echo " Open: http://localhost:7860"
echo " Press Ctrl+C to stop"
echo "========================================"
echo

docker compose --profile auto up
