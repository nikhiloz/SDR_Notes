# Analog Devices PlutoSDR (ADALM-PLUTO)

> **PlutoSDR** - An affordable full-duplex SDR designed for learning RF and communications.

---

## 1. Overview

The ADALM-PLUTO (PlutoSDR) is built around the Analog Devices AD9363 RF transceiver. It's designed for education but is capable enough for serious work.

```
    PLUTOSDR ARCHITECTURE

    ┌────────────────────────────────────────────────────────┐
    │                    ADALM-PLUTO                          │
    │                                                         │
    │  ┌──────────────┐     ┌──────────────┐                 │
    │  │   AD9363     │     │   Xilinx     │                 │
    │  │  RF AGILE    │────▶│   Zynq       │──── USB 2.0 ──▶│ PC
    │  │  TRANSCEIVER │◀────│   SoC        │                 │
    │  └──────┬───────┘     └──────────────┘                 │
    │         │                                               │
    │    ┌────┴────┐                                          │
    │    │ TX  RX  │ ← SMA connectors                        │
    │    └─────────┘                                          │
    └────────────────────────────────────────────────────────┘
```

---

## 2. Specifications

| Parameter | Stock | Firmware Hacked |
|-----------|-------|-----------------|
| **Freq Range** | 325–3800 MHz | 70–6000 MHz |
| **Bandwidth** | 20 MHz | 20 MHz |
| **ADC/DAC** | 12-bit | 12-bit |
| **Duplex** | Full | Full |
| **Interface** | USB 2.0 (OTG) | USB 2.0 |
| **TX Power** | up to +7 dBm | up to +7 dBm |
| **Price** | ~$150 | — |

---

## 3. Firmware Hack (Expand Frequency Range)

The PlutoSDR can be firmware-hacked to act like an AD9364 (wider range):

```bash
# Connect via SSH (default: root/analog)
ssh root@192.168.2.1

# Edit config
fw_setenv attr_name compatible
fw_setenv attr_val ad9364

# Also enable 2nd TX/RX channel (2x2 MIMO)
fw_setenv mode 2r2t

# Reboot
reboot
```

> **Warning:** This voids warranty. The extended range may have degraded performance at edges.

---

## 4. Software Support

| Software | Support | Notes |
|----------|---------|-------|
| GNU Radio | ✅ via gr-iio | Best framework support |
| SDR++ | ✅ | Good receiver |
| SDRangel | ✅ | TX and RX |
| MATLAB/Simulink | ✅ | Official AD support |
| libiio | ✅ | Native C API |
| PyADI | ✅ | Python bindings |

---

## 5. Setup (Linux)

```bash
# Install libiio
sudo apt install libiio-utils

# Verify connection
iio_info -s

# Test with GNU Radio
sudo apt install gr-iio
```

---

## 6. Use Cases

| Application | Why PlutoSDR |
|-------------|-------------|
| Learning TX/RX | Full duplex at low cost |
| OFDM experiments | 20 MHz BW, good for DVB-T |
| Radar projects | Full duplex enables FMCW |
| Cellular labs | Covers LTE bands |
| Amateur satellite | 70 cm + 23 cm bands (hacked) |

---

## 7. Limitations

- USB 2.0 limits sustained throughput (~4 MSPS complex)
- Stock frequency range is narrow (325–3800 MHz)
- Single antenna per direction (unless 2r2t hack)
- No TCXO — frequency drift until warm

---

*See also: [Hardware Comparison](Hardware_Comparison.md) | [Back to 02_Hardware](README.md)*
