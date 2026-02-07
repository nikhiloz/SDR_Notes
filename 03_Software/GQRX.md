# GQRX — Linux/Mac SDR Receiver

> **GQRX** - A popular open-source SDR receiver application for Linux and macOS.

---

## 1. Overview

GQRX is a Qt-based SDR receiver powered by GNU Radio under the hood. It provides a clean, simple GUI with spectrum display, waterfall, and audio output — ideal for Linux/Mac users.

---

## 2. Features

| Feature | Details |
|---------|---------|
| Spectrum + waterfall | Real-time FFT display |
| Audio demodulation | AM, FM (narrow/wide), SSB, CW, Raw I/Q |
| Recording | WAV audio and raw I/Q |
| Remote control | TCP interface for external scripts |
| Bookmarks | Save favourite frequencies |
| Hardware support | RTL-SDR, Airspy, HackRF, PlutoSDR, USRP (via gr-osmosdr / SoapySDR) |

---

## 3. Installation

```bash
# Ubuntu/Debian
sudo apt install gqrx-sdr

# From source (latest)
sudo apt install gnuradio gr-osmosdr libqt5-dev
git clone https://github.com/gqrx-sdr/gqrx.git
cd gqrx && mkdir build && cd build
cmake .. && make -j$(nproc)
sudo make install
```

---

## 4. Quick Start

1. Launch: `gqrx`
2. Select your SDR device in the I/O dialog
3. Set sample rate (e.g., 2.4 MSPS for RTL-SDR)
4. Press **Play** (▶)
5. Click on a signal in the spectrum/waterfall
6. Select demodulation mode (WFM for FM broadcast)
7. Adjust squelch and volume

---

## 5. Remote Control

GQRX exposes a TCP interface on port 7356:

```bash
# Enable: Tools → Remote Control → Enable

# From another terminal/script:
echo "F 100800000" | nc localhost 7356   # Set freq to 100.8 MHz
echo "M WFM_ST" | nc localhost 7356       # Set mode WFM Stereo
echo "f" | nc localhost 7356              # Query current freq
```

Useful for automated scanning scripts.

---

*See also: [SDR++ comparison](SDRPlusPlus.md) | [GNU Radio](GNU_Radio.md) | [Back to 03_Software](README.md)*
