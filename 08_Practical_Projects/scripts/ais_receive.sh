#!/bin/bash
# AIS Marine Receiver Script
# Tracks ships using RTL-SDR on VHF marine AIS frequencies
#
# Usage: ./ais_receive.sh [port]
# Example: ./ais_receive.sh 8100

PORT="${1:-8100}"

echo "🚢 AIS Marine Receiver"
echo "   Frequencies: 161.975 / 162.025 MHz"
echo "   Web UI: http://localhost:$PORT"
echo "   Press Ctrl+C to stop"
echo ""

# Check for AIS-catcher
if command -v AIS-catcher &>/dev/null; then
    AIS-catcher -N "$PORT"
elif command -v rtl_ais &>/dev/null; then
    echo "Using rtl_ais (basic mode)..."
    rtl_ais -p 0
else
    echo "❌ No AIS decoder found."
    echo ""
    echo "Install AIS-catcher (recommended):"
    echo "  git clone https://github.com/jvde-github/AIS-catcher.git"
    echo "  cd AIS-catcher && mkdir build && cd build"
    echo "  cmake .. && make -j\$(nproc) && sudo make install"
    echo ""
    echo "Or install rtl_ais:"
    echo "  sudo apt install rtl-ais"
    exit 1
fi
