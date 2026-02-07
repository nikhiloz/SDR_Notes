# CubicSDR — Cross-Platform SDR Application

> **CubicSDR** - A free, cross-platform SDR receiver with a modern interface.

---

## 1. Overview

CubicSDR is built on SoapySDR and liquid-dsp, providing a clean multi-platform SDR application. It works on Windows, Linux, and macOS with virtually any SDR hardware through SoapySDR.

---

## 2. Features

| Feature | Details |
|---------|---------|
| Cross-platform | Windows, Linux, macOS |
| Hardware support | Any SoapySDR-compatible device |
| Demodulation | AM, FM, NFM, WFM, USB, LSB, DSB, I/Q |
| Bookmarks | Frequency/label management |
| Recording | Audio recording |
| Multiple VFOs | Monitor several channels at once |

---

## 3. Installation

```bash
# Ubuntu
sudo apt install cubicsdr

# macOS (Homebrew)
brew install cubicsdr

# From source
sudo apt install libsoapysdr-dev libliquid-dev libwxgtk3.0-gtk3-dev
git clone https://github.com/cjcliffe/CubicSDR.git
cd CubicSDR && mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
```

---

## 4. When to Choose CubicSDR

| Pro | Con |
|-----|-----|
| True cross-platform | Fewer features than SDR# |
| Any SoapySDR hardware | Less plugin ecosystem |
| Clean, modern UI | Smaller community |
| Multiple VFOs | No advanced decoders built-in |

---

*See also: [GQRX](GQRX.md) | [SDR++](SDRPlusPlus.md) | [Back to 03_Software](README.md)*
