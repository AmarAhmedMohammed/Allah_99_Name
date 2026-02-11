#!/bin/bash

echo "============================================================"
echo "Downloading Beautiful Recitations of Allah's 99 Names"
echo "============================================================"
echo ""

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed"
    echo "Please install Python 3 first"
    exit 1
fi

# Install requests if needed
echo "Installing required packages..."
pip3 install requests > /dev/null 2>&1

# Run the download script
echo ""
echo "Starting download..."
echo ""
python3 download_audio.py

echo ""
echo "============================================================"
echo "Download process completed!"
echo "============================================================"
