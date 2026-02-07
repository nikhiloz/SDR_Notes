#!/bin/bash
# NOAA Weather Satellite Recorder
# Records a NOAA satellite pass and decodes the APT image
#
# Usage: ./noaa_record.sh [satellite] [duration_seconds]
# Example: ./noaa_record.sh NOAA19 900

SAT="${1:-NOAA19}"
DURATION="${2:-900}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="$HOME/SDR_Captures/NOAA"

# Satellite frequencies
case "$SAT" in
    NOAA15) FREQ=137620000 ;;
    NOAA18) FREQ=137912500 ;;
    NOAA19) FREQ=137100000 ;;
    *)
        echo "Unknown satellite: $SAT"
        echo "Options: NOAA15, NOAA18, NOAA19"
        exit 1
        ;;
esac

FREQ_MHZ=$(echo "scale=3; $FREQ/1000000" | bc)
WAV_FILE="${OUTPUT_DIR}/${SAT}_${TIMESTAMP}.wav"
IMG_FILE="${OUTPUT_DIR}/${SAT}_${TIMESTAMP}.png"

echo "🛰️  NOAA Weather Satellite Recorder"
echo "   Satellite:  $SAT"
echo "   Frequency:  $FREQ_MHZ MHz"
echo "   Duration:   $DURATION seconds"
echo "   Output:     $WAV_FILE"
echo ""

# Check dependencies
for cmd in rtl_fm sox; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "❌ Missing: $cmd"
        echo "   Install: sudo apt install rtl-sdr sox"
        exit 1
    fi
done

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Record
echo "Recording... (Ctrl+C to stop early)"
timeout "$DURATION" rtl_fm \
    -f "$FREQ" \
    -M fm \
    -s 60000 \
    -r 11025 \
    -g 48 \
    -p 0 \
    -E deemp \
    - | sox -t raw -r 11025 -e signed -b 16 -c 1 - "$WAV_FILE"

echo ""
echo "✅ Recording saved: $WAV_FILE"

# Try to decode if noaa-apt is available
if command -v noaa-apt &>/dev/null; then
    echo "Decoding APT image..."
    noaa-apt "$WAV_FILE" -o "$IMG_FILE"
    echo "✅ Image saved: $IMG_FILE"
else
    echo "ℹ️  Install noaa-apt to auto-decode:"
    echo "   https://noaa-apt.mbernardi.com.ar/"
fi
