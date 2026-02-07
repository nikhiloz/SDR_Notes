#!/bin/bash
# 433 MHz ISM Band Scanner
# Decodes wireless sensors, weather stations, and IoT devices
#
# Usage: ./ism_scan.sh [options]
# Example: ./ism_scan.sh --json --log

LOG_FILE=""
JSON_MODE=""

for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE="-F json" ;;
        --log)  LOG_FILE="$HOME/SDR_Captures/ism_$(date +%Y%m%d).json" ;;
        --help)
            echo "Usage: $0 [--json] [--log]"
            echo "  --json   Output in JSON format"
            echo "  --log    Log to ~/SDR_Captures/"
            exit 0
            ;;
    esac
done

echo "📡 433 MHz ISM Band Scanner"
echo "   Using rtl_433 to decode wireless devices"
echo "   Press Ctrl+C to stop"
echo ""

if ! command -v rtl_433 &>/dev/null; then
    echo "❌ rtl_433 not found."
    echo "   Install: sudo apt install rtl-433"
    echo "   Or: https://github.com/merbanan/rtl_433"
    exit 1
fi

# Build command
CMD="rtl_433"

if [ -n "$JSON_MODE" ]; then
    CMD="$CMD -F json"
fi

if [ -n "$LOG_FILE" ]; then
    mkdir -p "$(dirname "$LOG_FILE")"
    CMD="$CMD -F json:$LOG_FILE"
    echo "   Logging to: $LOG_FILE"
    echo ""
fi

# Run
$CMD
