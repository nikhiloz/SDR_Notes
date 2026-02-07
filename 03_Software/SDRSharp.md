# SDR# (SDRSharp)

> **SDR#** - The most popular Windows SDR receiver application, especially for RTL-SDR and Airspy.

---

## 1. Overview

SDR# (pronounced "SDR Sharp") is developed by Airspy and is the go-to SDR application on Windows. It offers excellent performance, a rich plugin ecosystem, and native Airspy support.

---

## 2. Features

| Feature | Details |
|---------|---------|
| Spectrum + waterfall | Fast, high-quality FFT |
| Demodulation | AM, FM, WFM, SSB, CW, DSB, RAW |
| Plugins | Huge ecosystem (DDE tracking, scanner, frequency manager, etc.) |
| Noise reduction | Noise blanker, noise reduction, IF noise |
| IF recording | Record raw I/Q for post-processing |
| SpyServer client | Connect to remote Airspy SDRs |
| Scheduling | Timed recording via plugins |

---

## 3. Installation

1. Download from [airspy.com/download](https://airspy.com/download/)
2. Extract ZIP
3. Run `install-rtlsdr.bat` (installs drivers for RTL-SDR)
4. If using non-RTL-SDR, install **Zadig** for USB driver
5. Launch `SDRSharp.exe`

---

## 4. Essential Plugins

| Plugin | Purpose |
|--------|---------|
| Frequency Manager + Scanner | Save freqs, auto-scan |
| DDE Tracking | Satellite tracking with Orbitron |
| IF Recorder | Record I/Q for later analysis |
| Level Meter | Signal strength measurement |
| Digital Audio Processor | Audio filtering/AGC |

---

## 5. Limitations

- **Windows only** (no Linux/Mac support)
- Closed source
- Airspy hardware gets best support; other hardware via community plugins
- No built-in transmit capability

---

*See also: [GQRX (Linux alternative)](GQRX.md) | [SDR++ (cross-platform)](SDRPlusPlus.md) | [Back to 03_Software](README.md)*
