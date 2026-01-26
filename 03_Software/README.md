# 03_Software

> **SDR Software** - Applications and frameworks for Software Defined Radio.

---

## 📖 Contents

| Document | Description |
|----------|-------------|
| [SDRSharp.md](SDRSharp.md) | SDR# - Popular Windows SDR software |
| [GQRX.md](GQRX.md) | GQRX - Linux/Mac SDR receiver |
| [GNU_Radio.md](GNU_Radio.md) | GNU Radio - DSP development framework |
| [CubicSDR.md](CubicSDR.md) | Cross-platform SDR application |
| [Specialized.md](Specialized.md) | Decoders and analysis tools |

---

## 🎯 Software Selection Guide

The following table helps choose SDR software based on needs:

| Need | Recommended Software | Platform |
|------|---------------------|----------|
| **Beginner, Windows** | SDR# | Windows |
| **Beginner, Linux/Mac** | GQRX, CubicSDR | Linux/Mac |
| **Cross-platform** | CubicSDR, SDRangel | All |
| **DSP Development** | GNU Radio | All |
| **ADS-B Tracking** | dump1090, tar1090 | All |
| **Satellite Imagery** | SatDump | All |
| **ISM Band Decoding** | rtl_433 | All |
| **Signal Analysis** | Inspectrum, URH | All |
| **Trunked Radio** | SDRTrunk, OP25 | All |

---

## 📊 Software Comparison

The following table compares major SDR applications:

| Software | Platform | GUI | Plugins | TX | Best For |
|----------|----------|-----|---------|-----|----------|
| **SDR#** | Windows | ✅ | ✅ | ❌ | Beginners, plugins |
| **GQRX** | Linux/Mac | ✅ | ❌ | ❌ | Linux users |
| **CubicSDR** | All | ✅ | ❌ | ❌ | Cross-platform |
| **SDRangel** | All | ✅ | ✅ | ✅ | Advanced, multi-channel |
| **SDR++** | All | ✅ | ✅ | ❌ | Modern, fast |
| **GNU Radio** | All | ✅* | ✅ | ✅ | Development, custom DSP |
| **SDRConsole** | Windows | ✅ | ✅ | ✅ | Ham radio |

> *GNU Radio Companion provides visual flowgraph editing

---

## 🔧 SDR Framework Architecture

The following diagram shows how SDR software layers work:

```
┌─────────────────────────────────────────────────────────────────┐
│                     USER APPLICATION                             │
│    (SDR#, GQRX, GNU Radio flowgraph, custom application)        │
├─────────────────────────────────────────────────────────────────┤
│                     SDR FRAMEWORK/LIBRARY                        │
│    (GNU Radio, SoapySDR, liquid-dsp)                            │
├─────────────────────────────────────────────────────────────────┤
│                     HARDWARE DRIVER                              │
│    (librtlsdr, libhackrf, UHD, LimeSuite)                       │
├─────────────────────────────────────────────────────────────────┤
│                     OPERATING SYSTEM                             │
│    (USB driver, kernel)                                          │
├─────────────────────────────────────────────────────────────────┤
│                     SDR HARDWARE                                 │
│    (RTL-SDR, HackRF, USRP, etc.)                                │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔌 Hardware Abstraction: SoapySDR

SoapySDR provides a common API for different SDR hardware:

```
                        SoapySDR Abstraction
                        
    ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
    │  SDR#    │  │  GQRX    │  │GNU Radio │  │ Custom   │
    │          │  │          │  │          │  │  App     │
    └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘
         │             │             │             │
         └─────────────┼─────────────┼─────────────┘
                       │             │
                       ▼             ▼
              ┌────────────────────────────┐
              │         SoapySDR           │
              │    (Hardware Abstraction)  │
              └───────────┬────────────────┘
                          │
         ┌────────┬───────┼───────┬────────┐
         ▼        ▼       ▼       ▼        ▼
    ┌────────┐┌───────┐┌──────┐┌───────┐┌──────┐
    │RTL-SDR ││HackRF ││PlutoSDR│LimeSDR││USRP  │
    └────────┘└───────┘└──────┘└───────┘└──────┘
```

---

## 📦 Essential Software by Category

### Receivers

| Software | Description | Link |
|----------|-------------|------|
| SDR# | Feature-rich Windows receiver | airspy.com |
| GQRX | Qt-based Linux/Mac receiver | gqrx.dk |
| CubicSDR | Cross-platform receiver | cubicsdr.com |
| SDR++ | Modern, fast receiver | github.com/AlexandreRouworx/SDRPlusPlus |
| SDRangel | Advanced multi-channel | github.com/f4exb/sdrangel |

### Frameworks

| Software | Description | Link |
|----------|-------------|------|
| GNU Radio | DSP framework | gnuradio.org |
| PySDR | Python SDR library | pysdr.org |
| liquid-dsp | C DSP library | liquidsdr.org |

### Decoders

| Software | Decodes | Link |
|----------|---------|------|
| dump1090 | ADS-B (aircraft) | github |
| rtl_433 | ISM band devices | github |
| multimon-ng | POCSAG, FLEX, AFSK | github |
| direwolf | APRS, packet | github |
| SatDump | Satellite imagery | github |

### Analysis

| Software | Purpose | Link |
|----------|---------|------|
| Inspectrum | Signal analysis | github |
| URH | Protocol reverse engineering | github |
| Baudline | Spectrum/spectrogram | baudline.com |

---

## 🐧 Linux Quick Setup

```bash
# RTL-SDR driver
sudo apt install rtl-sdr

# GQRX
sudo apt install gqrx-sdr

# GNU Radio
sudo apt install gnuradio

# SoapySDR
sudo apt install soapysdr-tools

# rtl_433
sudo apt install rtl-433

# dump1090
sudo apt install dump1090-mutability
```

---

## 🪟 Windows Quick Setup

1. **SDR#**: Download from airspy.com, run `install-rtlsdr.bat`
2. **Zadig**: Install WinUSB driver for SDR device
3. **SDR++**: Download from GitHub releases
4. **GNU Radio**: Use radioconda installer

---

*See individual software pages for detailed usage guides.*
