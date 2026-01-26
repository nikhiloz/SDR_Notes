# SDR++ Guide

> **SDR++** - Modern, cross-platform SDR receiver application.

---

## 📖 Contents

| Section | Description |
|---------|-------------|
| [Overview](#-overview) | What is SDR++ |
| [Installation](#-installation) | Setup on all platforms |
| [Interface](#-interface-guide) | UI walkthrough |
| [Configuration](#️-configuration) | Settings and tuning |
| [Modules](#-modules) | Demodulators and sources |
| [Tips](#-tips-and-tricks) | Best practices |

---

## 📻 Overview

### What is SDR++?

SDR++ is a modern, lightweight, cross-platform SDR receiver written in C++. It's designed for speed and flexibility.

The following diagram shows SDR++ architecture:

```
    SDR++ ARCHITECTURE
    
    ┌──────────────────────────────────────────────────────────────────┐
    │                          SDR++                                   │
    │                                                                  │
    │  ┌─────────────────────────────────────────────────────────────┐│
    │  │                      Frontend (ImGui)                        ││
    │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  ││
    │  │  │  FFT/       │  │  Waterfall  │  │   Control Panel     │  ││
    │  │  │  Spectrum   │  │   Display   │  │   - Source          │  ││
    │  │  │             │  │             │  │   - Demodulator     │  ││
    │  │  └─────────────┘  └─────────────┘  │   - Audio           │  ││
    │  │                                    └─────────────────────┘  ││
    │  └─────────────────────────────────────────────────────────────┘│
    │                              │                                   │
    │  ┌───────────────────────────┴───────────────────────────────┐  │
    │  │                     DSP Pipeline                          │  │
    │  │  Source → Resampler → Channelizer → Demod → Audio Out    │  │
    │  └───────────────────────────────────────────────────────────┘  │
    │                              │                                   │
    │  ┌───────────────────────────┴───────────────────────────────┐  │
    │  │                    Plugin System                          │  │
    │  │  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐  │  │
    │  │  │RTL-SDR │ │AirspyHF│ │PlutoSDR│ │HackRF  │ │  File  │  │  │
    │  │  │ Source │ │ Source │ │ Source │ │ Source │ │ Source │  │  │
    │  │  └────────┘ └────────┘ └────────┘ └────────┘ └────────┘  │  │
    │  └───────────────────────────────────────────────────────────┘  │
    └──────────────────────────────────────────────────────────────────┘
```

### Feature Comparison

| Feature | SDR++ | SDRSharp | GQRX |
|---------|-------|----------|------|
| **Platform** | Win/Mac/Linux | Windows | Linux/Mac |
| **Performance** | Excellent | Good | Good |
| **GPU Accel** | Yes | No | Yes |
| **Plugin System** | Yes | Yes | Limited |
| **Price** | Free | Free | Free |
| **Active Dev** | Yes | Yes | Moderate |

---

## 💻 Installation

### Windows

```
1. Download from https://www.sdrpp.org/
2. Extract ZIP to desired location
3. Run sdrpp.exe
4. Install appropriate drivers (Zadig for RTL-SDR)
```

### Linux (Ubuntu/Debian)

```bash
# Install dependencies
sudo apt install build-essential cmake git libfftw3-dev libglfw3-dev libvolk2-dev libzstd-dev libairspyhf-dev

# Clone repository
git clone https://github.com/AlexandreRouma/SDRPlusPlus.git
cd SDRPlusPlus

# Build
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
sudo make install
```

### macOS

```bash
# Using Homebrew
brew install sdrpp

# Or build from source
brew install cmake fftw glfw volk libairspyhf
git clone https://github.com/AlexandreRouma/SDRPlusPlus.git
cd SDRPlusPlus
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(sysctl -n hw.ncpu)
```

---

## 🖥️ Interface Guide

### Main Window Layout

```
    SDR++ INTERFACE
    
    ┌─────────────────────────────────────────────────────────────────┐
    │  File  Source  VFO  Module  Recording  View  Help              │
    ├────────────────────────────────────────────────────────┬────────┤
    │                                                        │        │
    │     ████████████████████████████████████████████████   │ Source │
    │     ███████████████▓▓▓▓▓▓▓▓▓██████████████████████     │  RTL   │
    │     █████████████▓▓░░░░░░░░▓▓████████████████████      │  SDR   │
    │     ███████████▓▓░░░░░░░░░░░░▓▓██████████████████      │        │
    │     ─────────────────────────────────────────────      │ ────── │
    │                    Spectrum                             │        │
    ├────────────────────────────────────────────────────────┤ Gain   │
    │     ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    │ [===]  │
    │     ░░░░░░░░░░░▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░    │        │
    │     ░░░░░░░░▓▓████████████▓▓░░░░░░░░░░░░░░░░░░░░░    │ ────── │
    │     ░░░░░░▓▓████████████████▓▓░░░░░░░░░░░░░░░░░░░    │        │
    │     ░░░░▓▓████████████████████▓▓░░░░░░░░░░░░░░░░░    │ Radio  │
    │     ─────────────────────────────────────────────      │  WFM   │
    │                    Waterfall                           │  NFM   │
    │                                                        │  AM    │
    │     ◄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓►    │  USB   │
    │              VFO Tuning Bar                            │  LSB   │
    ├────────────────────────────────────────────────────────┤        │
    │  Freq: 100.300.000 Hz    BW: 200 kHz    SNR: 45 dB   │ Audio  │
    └────────────────────────────────────────────────────────┴────────┘
```

### Key UI Elements

| Element | Function |
|---------|----------|
| **Spectrum** | Real-time FFT display |
| **Waterfall** | Time-frequency history |
| **VFO Bar** | Channel selection marker |
| **Source Panel** | SDR device settings |
| **Radio Panel** | Demodulator selection |
| **Audio Panel** | Volume and output |

---

## ⚙️ Configuration

### First-Time Setup

| Step | Action |
|------|--------|
| 1 | Select Source → RTL-SDR (or your device) |
| 2 | Click Play button to start receiving |
| 3 | Select Radio → WFM for FM broadcast |
| 4 | Click on waterfall to tune |
| 5 | Adjust Volume in Audio panel |

### Source Settings

| Setting | Purpose | Typical Value |
|---------|---------|---------------|
| **Sample Rate** | Bandwidth | 2.4 MSPS |
| **Center Freq** | Tuning | 100 MHz |
| **RF Gain** | Sensitivity | Auto/Manual |
| **Bias Tee** | Power LNA | Off/On |
| **PPM** | Freq correction | Device specific |

### Display Settings

```
    VIEW MENU OPTIONS
    
    ┌──────────────────────────────┐
    │ ☑ Show Waterfall             │
    │ ☑ Show FFT                   │
    │ ☐ Lock WF to FFT             │
    │ ────────────────────         │
    │ FFT Size: [4096 ▼]           │
    │ FPS: [60 ▼]                  │
    │ Color Map: [Turbo ▼]         │
    │ ────────────────────         │
    │ WF Min: [-100 dB]            │
    │ WF Max: [-40 dB]             │
    └──────────────────────────────┘
```

---

## 🔌 Modules

### Source Modules

| Module | Device Support |
|--------|---------------|
| rtl_sdr_source | RTL-SDR dongles |
| airspy_source | Airspy R2/Mini |
| airspyhf_source | Airspy HF+ |
| hackrf_source | HackRF One |
| plutosdr_source | ADALM-PLUTO |
| sdrplay_source | SDRPlay RSP |
| file_source | IQ recordings |
| rtl_tcp_source | Network RTL-SDR |

### Demodulator Modules

| Mode | Bandwidth | Use Case |
|------|-----------|----------|
| **WFM** | 200 kHz | FM broadcast |
| **NFM** | 12.5-25 kHz | Two-way radio |
| **AM** | 10 kHz | AM broadcast, air |
| **USB** | 2.4 kHz | SSB upper |
| **LSB** | 2.4 kHz | SSB lower |
| **CW** | 500 Hz | Morse code |
| **RAW** | Variable | Recording |

### Utility Modules

| Module | Function |
|--------|----------|
| recorder | Record IQ and audio |
| frequency_manager | Save frequencies |
| rigctl_server | CAT control |
| discord_rpc | Discord integration |

---

## 🎯 Tips and Tricks

### Performance Optimization

| Tip | Benefit |
|-----|---------|
| Reduce FFT size | Lower CPU usage |
| Lower FPS | Smoother on slow systems |
| Use GPU acceleration | Offload rendering |
| Close unused modules | Free resources |

### Keyboard Shortcuts

| Key | Action |
|-----|--------|
| Space | Start/Stop |
| Arrow Up/Down | Fine tune |
| Scroll wheel | Tune frequency |
| Ctrl+Scroll | Zoom waterfall |
| R | Toggle recording |

### Signal Hunting Tips

```
    FINDING SIGNALS
    
    1. Wide View First
       ┌────────────────────────────────────────┐
       │ Start with wide span to see activity  │
       │ 2+ MHz span, medium FFT               │
       └────────────────────────────────────────┘
    
    2. Identify Signal Type
       ┌────────────────────────────────────────┐
       │ Look at bandwidth, pattern, timing    │
       │ Reference signal guides               │
       └────────────────────────────────────────┘
    
    3. Zoom and Demodulate
       ┌────────────────────────────────────────┐
       │ Click signal, select appropriate mode │
       │ Adjust bandwidth to match signal      │
       └────────────────────────────────────────┘
```

### Recording Tips

| Recording Type | Use Case | File Size |
|----------------|----------|-----------|
| **Audio** | Voice, music | Small |
| **Baseband (IQ)** | Full analysis | Large |
| **Compressed IQ** | Storage-efficient | Medium |

---

## 🔧 Troubleshooting

### Common Issues

| Problem | Solution |
|---------|----------|
| No device found | Check USB, install drivers |
| No audio | Check Audio module, volume |
| Poor reception | Adjust gain, check antenna |
| Crashes on start | Update graphics drivers |
| High CPU | Reduce FFT size, lower FPS |

### Error Messages

| Error | Cause | Fix |
|-------|-------|-----|
| "No source selected" | No SDR chosen | Select in Source menu |
| "Could not open device" | Driver issue | Reinstall driver |
| "Sample rate not supported" | Invalid rate | Choose supported rate |

---

## 🔗 Resources

| Resource | Link |
|----------|------|
| Official Site | https://www.sdrpp.org/ |
| GitHub | https://github.com/AlexandreRouma/SDRPlusPlus |
| Discord | https://discord.gg/aFgxqQF |
| Wiki | https://github.com/AlexandreRouma/SDRPlusPlus/wiki |

---

*SDR++: Fast, modern, and just works!*
