# SDR_Notes 📻

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![SDR](https://img.shields.io/badge/SDR-Learning-blue.svg)]()
[![RF](https://img.shields.io/badge/RF-Engineering-green.svg)]()

> **Software Defined Radio** - Learning notes, reference documentation, and practical projects.

---

## 📖 About

This repository contains comprehensive documentation on Software Defined Radio (SDR) technology, covering everything from RF fundamentals to practical receiver projects.

## 🔗 Companion Repositories

This project is part of an integrated learning ecosystem. See how it relates to other projects:

| Repository | Purpose | Type | Content |
|-----------|---------|------|----------|
| [dsp-tutorial-suite](https://github.com/nikhiloz/dsp-tutorial-suite) | Foundation DSP algorithms & theory | Executable code | 30 chapters: signals, transforms, filters, analysis, adaptive filters |
| [wireless-comms-suite](https://github.com/nikhiloz/wireless-comms-suite) | Wireless communication systems | Executable code | 24 chapters: modulation, channel coding, real protocols (WiFi, Bluetooth, LoRa) |
| **SDR_Notes** (this repo) | SDR hardware & software reference | Documentation | 9 sections: RF fundamentals, hardware comparison, software tools, protocols |

**Use Case**: Reference material for [wireless-comms-suite](https://github.com/nikhiloz/wireless-comms-suite) and [dsp-tutorial-suite](https://github.com/nikhiloz/dsp-tutorial-suite)

---

The following diagram shows the typical SDR signal chain from antenna to computer:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SDR SIGNAL CHAIN                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────┐   ┌─────┐   ┌─────────┐   ┌─────┐   ┌─────┐   ┌──────────────┐ │
│  │ Antenna │──▶│ LNA │──▶│  Mixer  │──▶│ ADC │──▶│ USB │──▶│   Computer   │ │
│  └─────────┘   └─────┘   └────┬────┘   └─────┘   └─────┘   │  (Software)  │ │
│                               │                            └──────────────┘ │
│                        ┌──────┴──────┐                                       │
│                        │ Local Osc.  │  ← Tuning                             │
│                        │  (Tuner)    │                                       │
│                        └─────────────┘                                       │
│                                                                              │
│  RF Front-End ◄────────────────────────────▶  Digital Back-End              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 📁 Repository Structure

| Folder | Description |
|--------|-------------|
| [01_Fundamentals](01_Fundamentals/) | RF basics, sampling theory, I/Q signals |
| [02_Hardware](02_Hardware/) | SDR hardware (RTL-SDR, HackRF, PlutoSDR, etc.) |
| [03_Software](03_Software/) | SDR software (GNU Radio, SDR#, GQRX, etc.) |
| [04_DSP_Fundamentals](04_DSP_Fundamentals/) | Digital Signal Processing basics |
| [05_Modulation](05_Modulation/) | AM, FM, FSK, PSK, QAM, OFDM |
| [06_Protocols](06_Protocols/) | ADS-B, AIS, NOAA, DMR, LoRa, etc. |
| [07_Spectrum_Analysis](07_Spectrum_Analysis/) | Signal identification, band plans |
| [08_Practical_Projects](08_Practical_Projects/) | Hands-on SDR projects |
| [09_Advanced_Topics](09_Advanced_Topics/) | MIMO, direction finding, TX |
| [Reference](Reference/) | Quick reference charts and tables |

---

## 🎯 Quick Start

### Recommended Learning Path

The following table shows the recommended order for learning SDR concepts:

| Step | Topic | Document |
|------|-------|----------|
| 1 | What is SDR? | [01_Fundamentals/What_Is_SDR.md](01_Fundamentals/What_Is_SDR.md) |
| 2 | RF Basics | [01_Fundamentals/RF_Basics.md](01_Fundamentals/RF_Basics.md) |
| 3 | I/Q Signals | [01_Fundamentals/Quadrature_Signals.md](01_Fundamentals/Quadrature_Signals.md) |
| 4 | Get Hardware | [02_Hardware/RTL_SDR.md](02_Hardware/RTL_SDR.md) |
| 5 | Install Software | [03_Software/SDRSharp.md](03_Software/SDRSharp.md) |
| 6 | First Project | [08_Practical_Projects/Project_FM_Radio.md](08_Practical_Projects/Project_FM_Radio.md) |

---

## 📻 SDR Hardware Comparison

The following table compares popular SDR receivers across key specifications:

| SDR | Freq Range | BW | Bits | TX | Price | Best For |
|-----|------------|-----|------|-----|-------|----------|
| **RTL-SDR v3** | 24-1766 MHz | 2.4 MHz | 8 | ❌ | ~$30 | Beginners |
| **RTL-SDR v4** | 24-1766 MHz | 2.4 MHz | 8 | ❌ | ~$40 | Entry + HF |
| **HackRF One** | 1-6000 MHz | 20 MHz | 8 | ✅ | ~$300 | Wide range TX/RX |
| **Airspy Mini** | 24-1800 MHz | 6 MHz | 12 | ❌ | ~$100 | Quality RX |
| **SDRPlay RSP1A** | 1k-2000 MHz | 10 MHz | 14 | ❌ | ~$110 | Value |
| **PlutoSDR** | 325-3800 MHz | 20 MHz | 12 | ✅ | ~$150 | Learning TX |
| **LimeSDR Mini** | 10-3500 MHz | 30 MHz | 12 | ✅ | ~$200 | Full duplex |
| **USRP B200** | 70-6000 MHz | 56 MHz | 12 | ✅ | ~$1200 | Professional |

---

## 🔧 Software Tools

The following table lists commonly used SDR software applications:

| Software | Platform | Purpose | Link |
|----------|----------|---------|------|
| **SDR#** | Windows | General SDR receiver | [airspy.com](https://airspy.com/download/) |
| **GQRX** | Linux/Mac | General SDR receiver | [gqrx.dk](https://gqrx.dk/) |
| **GNU Radio** | All | DSP framework | [gnuradio.org](https://www.gnuradio.org/) |
| **CubicSDR** | All | Cross-platform SDR | [cubicsdr.com](https://cubicsdr.com/) |
| **SDRangel** | All | Advanced multi-channel | [github](https://github.com/f4exb/sdrangel) |
| **Inspectrum** | Linux | Signal analysis | [github](https://github.com/miek/inspectrum) |
| **URH** | All | Protocol reverse engineering | [github](https://github.com/jopohl/urh) |

---

## 📡 Common Frequencies

The following table lists interesting frequencies to explore with an SDR:

| Frequency | Signal | Notes |
|-----------|--------|-------|
| 88-108 MHz | FM Broadcast | Great for first test |
| 118-137 MHz | Aircraft (AM) | Air traffic control |
| 137 MHz | NOAA Satellites | Weather images |
| 144-148 MHz | 2m Amateur | Ham radio |
| 156.8 MHz | Marine VHF Ch16 | Distress/calling |
| 162.4-162.55 MHz | NOAA Weather | Weather radio |
| 433 MHz | ISM Band | Remote controls, sensors |
| 462-467 MHz | FRS/GMRS | Walkie-talkies |
| 858-868 MHz | ISM (EU) | LoRa, sensors |
| 1090 MHz | ADS-B | Aircraft tracking |

---

## � Related Repositories

| Repository | Description |
|-----------|-------------|
| [dsp-tutorial-suite](https://github.com/nikhiloz/dsp-tutorial-suite) | Companion C-based DSP tutorial — 30 chapters covering FFT, filters, modulation/demodulation with working code |

The DSP concepts in `04_DSP_Fundamentals/` cross-reference specific chapters from the dsp-tutorial-suite for hands-on C implementations.

---

## 📚 References

- [RTL-SDR Blog](https://www.rtl-sdr.com/)
- [PySDR Textbook](https://pysdr.org/)
- [GNU Radio Wiki](https://wiki.gnuradio.org/)
- [Signal Identification Wiki](https://www.sigidwiki.com/)
- [SigIDWiki](https://www.sigidwiki.com/) — Signal identification database

---

## 📜 License

This work is licensed under the MIT License.

---

*Created: January 2026 | Author: Nikhil Pandey*
