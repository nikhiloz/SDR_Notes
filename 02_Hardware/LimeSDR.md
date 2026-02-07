# LimeSDR

> **LimeSDR** - Open-source, full-duplex, high-bandwidth SDR platform.

---

## 1. Overview

LimeSDR is based on the Lime Microsystems LMS7002M transceiver. It's fully open-source (hardware + gateware + software) and offers full-duplex operation with wide bandwidth.

---

## 2. Product Line

| Model | Freq Range | BW | ADC/DAC | TX Channels | RX Channels | Price |
|-------|------------|-----|---------|-------------|-------------|-------|
| **LimeSDR Mini v2** | 10–3500 MHz | 30 MHz | 12-bit | 1 | 1 | ~$200 |
| **LimeSDR** (full) | 100k–3800 MHz | 61 MHz | 12-bit | 2 | 2 | ~$300 |
| **LimeNET Micro** | 10–3500 MHz | 30 MHz | 12-bit | 1 | 1 | ~$300 |

---

## 3. Architecture

```
    LIMESDR ARCHITECTURE

    ┌────────────────────────────────────────────────────────┐
    │                                                         │
    │            ┌──────────────────────┐                     │
    │  TX SMA ◀──│                      │                     │
    │            │     LMS7002M         │                     │
    │  RX SMA ──▶│  RF TRANSCEIVER     │──── Altera/Intel ──▶│ USB 3.0
    │            │  2×TX  2×RX         │     Cyclone IV      │
    │  TX SMA ◀──│  12-bit 61 MHz BW   │     FPGA            │
    │            │                      │                     │
    │  RX SMA ──▶│                      │                     │
    │            └──────────────────────┘                     │
    │                                                         │
    └────────────────────────────────────────────────────────┘
```

---

## 4. Key Features

| Feature | Details |
|---------|---------|
| Full duplex | TX and RX simultaneously |
| MIMO | 2×2 on full LimeSDR |
| Open source | Schematics, gateware, software — all open |
| Wide BW | 61 MHz on full, 30 MHz on Mini |
| USB 3.0 | High throughput |

---

## 5. Software Support

| Software | Support |
|----------|---------|
| Lime Suite | ✅ (native configuration/calibration) |
| GNU Radio | ✅ via gr-limesdr or SoapySDR |
| SDRangel | ✅ |
| SDR++ | ✅ |
| GQRX | ✅ via SoapySDR |
| Pothos | ✅ |

### Linux Setup

```bash
# Install LimeSuite
sudo add-apt-repository -y ppa:myriadrf/drivers
sudo apt update
sudo apt install limesuite limesuite-udev soapysdr-module-lms7

# Verify
LimeUtil --find

# Run GUI
LimeQuickTest
```

---

## 6. Applications

| Application | Why LimeSDR |
|-------------|-------------|
| GSM/LTE base stations (OpenBTS, srsRAN) | Full duplex + wide BW |
| LoRa gateway | TX/RX on ISM bands |
| DVB-T/DAB transmission | High instantaneous BW |
| MIMO research | 2×2 channels with shared clock |
| Radar prototyping | Fast TX/RX switching |

---

*See also: [Hardware Comparison](Hardware_Comparison.md) | [Back to 02_Hardware](README.md)*
