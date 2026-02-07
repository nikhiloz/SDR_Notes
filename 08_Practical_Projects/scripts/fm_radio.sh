#!/bin/bash
# FM Radio Receiver — Quick Start Script
# Receives FM broadcast using RTL-SDR and plays through speakers
#
# Usage: ./fm_radio.sh [frequency_MHz]
# Example: ./fm_radio.sh 98.3

FREQ_MHZ="${1:-98.3}"
FREQ_HZ=$(echo "$FREQ_MHZ * 1000000" | bc | cut -d. -f1)

echo "📻 FM Radio Receiver"
echo "   Frequency: ${FREQ_MHZ} MHz"
echo "   Press Ctrl+C to stop"
echo ""

# Check dependencies
for cmd in rtl_fm aplay; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "❌ Missing: $cmd"
        echo "   Install: sudo apt install rtl-sdr alsa-utils"
        exit 1
    fi
done

# Receive and play
rtl_fm -f "$FREQ_HZ" -M wbfm -s 200000 -r 48000 - | \
    aplay -r 48000 -f S16_LE -t raw -c 1
