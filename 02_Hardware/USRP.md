# Ettus USRP Series

> **USRP** - The professional/research-grade SDR platform from Ettus Research (National Instruments).

---

## 1. Overview

The Universal Software Radio Peripheral (USRP) is the de facto standard for SDR research, used in universities, government labs, and industry worldwide. It runs on the UHD (USRP Hardware Driver) framework.

---

## 2. Product Line

| Model | Freq Range | BW | ADC/DAC | TX | RX | Interface | Price |
|-------|------------|-----|---------|----|----|-----------|-------|
| **B200** | 70–6000 MHz | 56 MHz | 12-bit | 1 | 1 | USB 3.0 | ~$1,200 |
| **B210** | 70–6000 MHz | 56 MHz | 12-bit | 2 | 2 | USB 3.0 | ~$2,300 |
| **N310** | 10–6000 MHz | 100 MHz | 14-bit | 4 | 4 | 10 GbE | ~$8,000 |
| **X310** | DC–6 GHz | 160 MHz | 14-bit | 2 | 2 | 10 GbE / PCIe | ~$6,000+ |
| **E320** | 10–6000 MHz | 100 MHz | varies | 2 | 2 | Embedded (Zynq) | ~$4,000 |

---

## 3. Architecture

```
    USRP B210 ARCHITECTURE

    ┌────────────────────────────────────────────────────────────┐
    │                                                             │
    │   TX/RX A ◀──┐  ┌──────────────┐   ┌──────────────┐       │
    │     (SMA)    ├──│   AD9361     │──▶│   Spartan-6  │──USB3──▶ PC
    │   RX A   ──▶─┘  │  RF AGILE   │◀──│   FPGA       │       │
    │              ┌──│  TRANSCEIVER │──▶│              │       │
    │   TX/RX B ◀──┘  │  2×2 MIMO   │◀──│              │       │
    │     (SMA)    ┌──│              │   └──────────────┘       │
    │   RX B   ──▶─┘  └──────────────┘                          │
    │                                                             │
    │   + GPSDO option (external 10 MHz / PPS)                   │
    └────────────────────────────────────────────────────────────┘
```

---

## 4. UHD (USRP Hardware Driver)

UHD is the open-source driver and API for all USRP devices:

```bash
# Install UHD
sudo apt install uhd-host libuhd-dev

# Download FPGA images
sudo uhd_images_downloader

# Find connected devices
uhd_find_devices

# Quick test
uhd_usrp_probe
```

---

## 5. Software Ecosystem

| Software | Support | Notes |
|----------|---------|-------|
| GNU Radio | ✅ (native UHD source/sink) | Primary framework |
| MATLAB/Simulink | ✅ | Communications Toolbox |
| LabVIEW | ✅ | NI integration |
| srsRAN | ✅ | 4G/5G base station |
| OpenAirInterface | ✅ | 5G NR research |
| Custom C++/Python | ✅ via UHD API | Full control |

---

## 6. When to Choose USRP

| Need | Why USRP |
|------|----------|
| Phase-coherent multi-channel | External 10 MHz ref + PPS |
| Wide instantaneous bandwidth | Up to 160 MHz |
| High-speed streaming | 10 GbE (N/X series) |
| Cellular base station research | srsRAN / OAI support |
| Published, citable platform | Standard in academic papers |

---

## 7. B200 vs B210

| Feature | B200 | B210 |
|---------|------|------|
| Channels | 1×1 | 2×2 MIMO |
| BW | 56 MHz | 56 MHz |
| GPSDO | Optional | Optional |
| Size | Small | Small |
| Price | $1,200 | $2,300 |

For most learning and single-channel work, the **B200** is sufficient. Choose **B210** for MIMO experiments.

---

*See also: [Hardware Comparison](Hardware_Comparison.md) | [Back to 02_Hardware](README.md)*
