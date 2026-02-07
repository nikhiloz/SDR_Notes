#!/bin/bash
# ADS-B Receiver Setup Script
# Installs dump1090-fa and sets up aircraft tracking
#
# Usage: ./adsb_setup.sh

set -e

echo "✈️  ADS-B Receiver Setup"
echo "========================"
echo ""

# Check for RTL-SDR
if ! command -v rtl_test &>/dev/null; then
    echo "Installing RTL-SDR drivers..."
    sudo apt update
    sudo apt install -y rtl-sdr librtlsdr-dev
fi

# Test RTL-SDR device
echo "Testing RTL-SDR..."
if ! rtl_test -t 2>/dev/null | head -5; then
    echo "❌ No RTL-SDR device found. Connect your SDR and try again."
    exit 1
fi
echo "✅ RTL-SDR detected"
echo ""

# Install dump1090
echo "Installing dump1090..."
sudo apt install -y build-essential pkg-config libncurses5-dev

if [ ! -d "dump1090" ]; then
    git clone https://github.com/flightaware/dump1090.git
fi

cd dump1090
make clean && make -j$(nproc)

echo ""
echo "✅ Setup complete!"
echo ""
echo "To start tracking aircraft:"
echo "  cd dump1090"
echo "  ./dump1090 --interactive --net"
echo ""
echo "Then open http://localhost:8080 in your browser"
echo ""
echo "For background operation:"
echo "  ./dump1090 --net --quiet &"
