# HackRF One

> **HackRF One** - The versatile half-duplex transceiver for advanced SDR work.

---

## 📖 Contents

| Section | Description |
|---------|-------------|
| [Overview](#-overview) | What is HackRF One |
| [Specifications](#-specifications) | Technical specs |
| [Block Diagram](#-block-diagram) | Internal architecture |
| [Comparison](#-comparison-with-other-sdrs) | HackRF vs others |
| [Setup](#️-setup) | Installation and first use |
| [Advanced Features](#-advanced-features) | TX, sweep, hackrf_transfer |
| [Accessories](#-accessories) | PortaPack, antennas |

---

## 📻 Overview

### What is HackRF One?

HackRF One is an open-source, half-duplex Software Defined Radio platform capable of transmission and reception from 1 MHz to 6 GHz.

The following diagram shows HackRF One's key features:

```
    HACKRF ONE KEY FEATURES
    
    ┌─────────────────────────────────────────────────────────────────────┐
    │                                                                      │
    │   WIDE FREQUENCY RANGE              HALF-DUPLEX TX/RX               │
    │   ────────────────────              ─────────────────               │
    │                                                                      │
    │   1 MHz ◄────────────────────────────────────────────► 6 GHz        │
    │         │     │      │       │        │        │                    │
    │        AM    FM    ADS-B   WiFi   Cellular   5GHz                   │
    │                                                                      │
    │   ┌──────────────────────────────────────────────────────────────┐  │
    │   │                                                               │  │
    │   │    ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────────┐   │  │
    │   │    │RF Front │  │  MAX2837│  │ MAX5864 │  │  LPC4320    │   │  │
    │   │    │ End     │─▶│Transceiv│─▶│ ADC/DAC │─▶│ ARM Cortex  │   │  │
    │   │    └─────────┘  └─────────┘  └─────────┘  └──────┬──────┘   │  │
    │   │                                                   │          │  │
    │   │                                            USB 2.0│          │  │
    │   │                                                   ▼          │  │
    │   │                                           ┌──────────────┐   │  │
    │   │                                           │   Computer   │   │  │
    │   │                                           └──────────────┘   │  │
    │   │                                                               │  │
    │   └──────────────────────────────────────────────────────────────┘  │
    │                                                                      │
    │   ✅ Open Source Hardware          ✅ Up to 20 MSPS                  │
    │   ✅ Open Source Firmware          ✅ TX Capable (low power)         │
    │   ✅ 20 MHz Bandwidth              ✅ USB 2.0 Powered                 │
    │                                                                      │
    └─────────────────────────────────────────────────────────────────────┘
```

---

## 📊 Specifications

### Core Specifications

The following table lists HackRF One's specifications:

| Parameter | Value | Notes |
|-----------|-------|-------|
| **Frequency Range** | 1 MHz - 6 GHz | Near continuous coverage |
| **Sample Rate** | 2 - 20 MSPS | 8-bit I/Q |
| **Bandwidth** | Up to 20 MHz | Real-time |
| **ADC Resolution** | 8 bits | MAX5864 |
| **Mode** | Half-duplex | TX or RX, not both |
| **TX Power** | 0-15 dBm | Varies by frequency |
| **Interface** | USB 2.0 | High-Speed |
| **Power** | USB powered | ~500 mA |
| **Connector** | SMA Female | 50Ω |
| **Size** | 120 x 75 x 13 mm | Without enclosure |

### Frequency Coverage

| Band | Range | Notes |
|------|-------|-------|
| HF | 1 - 30 MHz | Limited sensitivity |
| VHF | 30 - 300 MHz | Good performance |
| UHF | 300 MHz - 3 GHz | Best range |
| SHF | 3 - 6 GHz | Usable |

### Performance Characteristics

| Parameter | Typical Value |
|-----------|---------------|
| Noise Figure | 10-15 dB (no LNA) |
| Input IP3 | Varies |
| Frequency Accuracy | ±20 PPM |
| Phase Noise | Moderate |

---

## 🔧 Block Diagram

### Internal Architecture

The following diagram shows HackRF One's internal signal path:

```
    HACKRF ONE INTERNAL ARCHITECTURE
    
    ┌──────────────────────────────────────────────────────────────────────┐
    │                                                                       │
    │  SMA                                                                  │
    │   │                                                                   │
    │   ▼                                                                   │
    │ ┌──────────────────────────────────────────────────────────────────┐ │
    │ │                           RF SECTION                              │ │
    │ │                                                                   │ │
    │ │  ┌──────────┐    ┌────────┐    ┌──────────┐    ┌────────────┐   │ │
    │ │  │ RF Switch│───▶│ Filter │───▶│ MGA-81563│───▶│  MAX2837   │   │ │
    │ │  │ TX/RX    │    │ Select │    │   LNA    │    │ Transceiver│   │ │
    │ │  └──────────┘    └────────┘    └──────────┘    └─────┬──────┘   │ │
    │ │       │                                              │          │ │
    │ └───────┼──────────────────────────────────────────────┼──────────┘ │
    │         │                                              │            │
    │         │                                              ▼            │
    │ ┌───────┼──────────────────────────────────────────────────────────┐│
    │ │       │              BASEBAND SECTION                            ││
    │ │       │                                                          ││
    │ │       │         ┌──────────┐         ┌───────────────┐          ││
    │ │       │         │ MAX5864  │         │    LPC4320    │          ││
    │ │       │         │ ADC: 8-bit         │  ARM Cortex M4 │          ││
    │ │       │         │ DAC: 8-bit│◄──────▶│  + Cortex M0  │          ││
    │ │       │         │ 22 MSPS  │         │               │          ││
    │ │       │         └──────────┘         └───────┬───────┘          ││
    │ │       │                                      │                   ││
    │ └───────┼──────────────────────────────────────┼───────────────────┘│
    │         │                                      │                    │
    │         │            ┌─────────────────────────┤                    │
    │         ▼            ▼                         ▼                    │
    │    ┌─────────┐  ┌─────────┐            ┌───────────┐               │
    │    │ TX Path │  │ Clocks  │            │ USB 2.0   │               │
    │    │ PA      │  │ Si5351C │            │ Interface │               │
    │    └─────────┘  └─────────┘            └───────────┘               │
    │                                              │                      │
    └──────────────────────────────────────────────┼──────────────────────┘
                                                   │
                                                   ▼
                                            ┌────────────┐
                                            │  Computer  │
                                            └────────────┘
```

---

## 📈 Comparison with Other SDRs

### Feature Comparison

| Feature | HackRF One | RTL-SDR | PlutoSDR | USRP B200 |
|---------|------------|---------|----------|-----------|
| **Freq Range** | 1M-6G | 24M-1.7G | 325M-3.8G | 70M-6G |
| **TX** | ✅ Yes | ❌ No | ✅ Yes | ✅ Yes |
| **Bandwidth** | 20 MHz | 2.4 MHz | 20 MHz | 56 MHz |
| **Bits** | 8 | 8 | 12 | 12 |
| **Full Duplex** | ❌ No | ❌ No | ✅ Yes | ✅ Yes |
| **Price** | ~$300 | ~$30 | ~$150 | ~$1000+ |
| **Open Source** | ✅ Yes | Partial | ❌ No | ❌ No |

### When to Choose HackRF

| Use Case | HackRF? | Reason |
|----------|---------|--------|
| Wide frequency exploration | ✅ | 1 MHz - 6 GHz |
| Low-power TX experiments | ✅ | Built-in TX |
| Portable with PortaPack | ✅ | Standalone operation |
| High dynamic range RX | ❌ | Only 8-bit ADC |
| Full duplex | ❌ | Half-duplex only |
| High-power TX | ❌ | Low TX power |

---

## 🛠️ Setup

### Linux Installation

```bash
# Install hackrf tools
sudo apt install hackrf

# Check firmware version
hackrf_info

# Update firmware if needed
hackrf_spiflash -w hackrf_one_usb.bin
```

### Windows Installation

1. Download Zadig from https://zadig.akeo.ie/
2. Run Zadig, select HackRF One
3. Install WinUSB driver
4. Install hackrf-tools or use with SDR software

### First Test

The following commands verify your HackRF is working:

```bash
# Show device info
hackrf_info

# Expected output:
# hackrf_info version: 2021.03.1
# libhackrf version: 2021.03.1 (0.6)
# Found HackRF
# Index: 0
# Serial number: 0000000000000000...
# Board ID Number: 2 (HackRF One)
# Firmware Version: 2021.03.1
# Part ID Number: 0xa000cb3c 0x00574359
```

---

## 📡 Advanced Features

### Sweep Mode

HackRF can sweep across its entire range quickly:

```bash
# Sweep 1 MHz to 6 GHz, output to file
hackrf_sweep -f 1:6000 -w sweep_output.txt

# Sweep with specific step
hackrf_sweep -f 88:108 -w fm_band.txt
```

### hackrf_transfer

Raw I/Q capture and playback:

```bash
# Capture to file
hackrf_transfer -r capture.raw -f 433920000 -s 8000000 -n 8000000

# Playback from file (TRANSMIT - be careful!)
hackrf_transfer -t capture.raw -f 433920000 -s 8000000
```

### Sample Rates

| Rate | Bandwidth | Notes |
|------|-----------|-------|
| 2 MSPS | ~1.6 MHz | Minimum |
| 8 MSPS | ~6.4 MHz | Common |
| 10 MSPS | ~8 MHz | Good balance |
| 20 MSPS | ~16 MHz | Maximum |

---

## 🔌 Accessories

### PortaPack H1/H2

The PortaPack transforms HackRF into a standalone device:

```
    HACKRF + PORTAPACK
    
    ┌─────────────────────────────────────────┐
    │ ┌─────────────────────────────────────┐ │
    │ │                                     │ │
    │ │        LCD Touchscreen              │ │
    │ │                                     │ │
    │ │   ┌───────────────────────────┐     │ │
    │ │   │   Spectrum Display        │     │ │
    │ │   │   ▁▂▃▅▆█▆▅▃▂▁             │     │ │
    │ │   └───────────────────────────┘     │ │
    │ │                                     │ │
    │ │   [Capture] [Replay] [Analyze]      │ │
    │ │                                     │ │
    │ └─────────────────────────────────────┘ │
    │ ┌─────────────────────────────────────┐ │
    │ │          HackRF One                 │ │
    │ │                                     │ │
    │ └─────────────────────────────────────┘ │
    │   [Encoder]  [SD Card]  [Battery]       │
    └─────────────────────────────────────────┘
```

### PortaPack Features

| Feature | Description |
|---------|-------------|
| **Touchscreen** | 320x240 LCD |
| **SD Card** | Record/playback |
| **Battery** | Portable operation |
| **Standalone** | No computer needed |
| **Mayhem Firmware** | Enhanced features |

### Recommended Antennas

| Antenna | Frequency Range | Use Case |
|---------|-----------------|----------|
| ANT500 | 75M - 1G | General purpose |
| Telescopic | 50M - 600M | Portable |
| Log-periodic | 200M - 1.5G | Wide band |
| Yagi | Specific band | Directional |
| Discone | 25M - 1.5G | Scanner antenna |

---

## ⚠️ Important Notes

### TX Regulations

**TRANSMITTING REQUIRES A LICENSE!**

| Country | Requirement |
|---------|-------------|
| USA | FCC license for most bands |
| EU | Similar restrictions |
| All | Keep TX power low, use dummy load |

### RF Safety

| Precaution | Reason |
|------------|--------|
| Use dummy load for TX tests | Prevent interference |
| Don't transmit near airports | ATC frequencies |
| Know your local laws | Avoid legal issues |
| Use shielded enclosure | Contain emissions |

---

## 🔗 Resources

| Resource | Link |
|----------|------|
| Official Site | https://greatscottgadgets.com/hackrf/ |
| GitHub | https://github.com/greatscottgadgets/hackrf |
| Wiki | https://github.com/greatscottgadgets/hackrf/wiki |
| PortaPack Mayhem | https://github.com/eried/portapack-mayhem |

---

*HackRF One: The swiss-army knife of SDR.*
