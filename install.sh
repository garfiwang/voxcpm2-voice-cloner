#!/bin/bash
set -e

echo "============================================"
echo "  VoxCPM2 Voice Cloner - macOS/Linux Installer"
echo "============================================"
echo ""

# Find uv
UV_PATH="uv"
if command -v uv &> /dev/null; then
    UV_PATH="uv"
elif [ -f "$HOME/.local/bin/uv" ]; then
    UV_PATH="$HOME/.local/bin/uv"
else
    echo "uv not found, attempting to install uv using pip..."
    pip3 install -U uv
    if command -v uv &> /dev/null; then
        UV_PATH="uv"
    elif [ -f "$HOME/.local/bin/uv" ]; then
        UV_PATH="$HOME/.local/bin/uv"
    else
        echo "Error: uv could not be installed. Please install uv manually and try again."
        exit 1
    fi
fi

echo "Using uv at: $UV_PATH"

# Create python 3.12 environment
echo "[1/4] Creating virtual environment (.venv) with Python 3.12..."
"$UV_PATH" venv --python 3.12 .venv

# Activate venv for installation
source .venv/bin/activate

# Install PyTorch
echo "[2/4] Installing PyTorch..."
"$UV_PATH" pip install torch

# Install other dependencies
echo "[3/4] Installing voxcpm, sounddevice, resampy, gradio, numpy, soundfile..."
"$UV_PATH" pip install voxcpm sounddevice resampy gradio numpy soundfile

# Save gpu type as cpu
echo "[4/4] Writing device configuration..."
echo "cpu" > .gpu_type

echo "============================================"
echo "  Installation Complete!"
echo "============================================"
echo "To run the Web UI recording interface:"
echo "  .venv/bin/python webui_record.py"
echo ""
echo "To run cloning:"
echo "  .venv/bin/python clone.py \"text\" --voice \"name\""
