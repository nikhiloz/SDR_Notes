# 02_Hardware

> **SDR Hardware** - Comprehensive guide to Software Defined Radio hardware.

---

## 📖 Contents

| Document | Description |
|----------|-------------|
| [RTL_SDR.md](RTL_SDR.md) | RTL-SDR (RTL2832U) - Best entry-level SDR |
| [HackRF_One.md](HackRF_One.md) | HackRF One - Wideband TX/RX |
| [PlutoSDR.md](PlutoSDR.md) | Analog Devices PlutoSDR |
| [Airspy.md](Airspy.md) | Airspy Mini, R2, HF+ |
| [SDRPlay.md](SDRPlay.md) | SDRPlay RSP series |
| [LimeSDR.md](LimeSDR.md) | LimeSDR Mini/Full |
| [USRP.md](USRP.md) | Ettus USRP series |
| [Hardware_Comparison.md](Hardware_Comparison.md) | Full comparison table |

---

## 🎯 Quick Selection Guide

The following table helps choose an SDR based on use case:

| Use Case | Recommended SDR | Price |
|----------|-----------------|-------|
| **Learning/First SDR** | RTL-SDR v3/v4 | $30-40 |
| **Quality RX, VHF/UHF** | Airspy Mini | $100 |
| **Wide coverage, RX only** | SDRPlay RSP1A | $110 |
| **Learning TX/RX** | PlutoSDR | $150 |
| **Wideband TX/RX** | HackRF One | $300 |
| **Full duplex, high BW** | LimeSDR Mini | $200 |
| **Professional/Research** | USRP B200 | $1200+ |

---

## 📊 Master Comparison

The following table compares all major SDRs across key specifications:

| SDR | Freq Range | BW | Bits | TX | Duplex | Price |
|-----|------------|-----|------|-----|--------|-------|
| **RTL-SDR v3** | 24-1766 MHz | 2.4 MHz | 8 | ❌ | N/A | ~$30 |
| **RTL-SDR v4** | 24-1766 MHz | 2.4 MHz | 8 | ❌ | N/A | ~$40 |
| **Airspy Mini** | 24-1800 MHz | 6 MHz | 12 | ❌ | N/A | ~$100 |
| **Airspy R2** | 24-1800 MHz | 10 MHz | 12 | ❌ | N/A | ~$170 |
| **Airspy HF+** | 9k-31M, 60-260M | 0.768 MHz | 18 | ❌ | N/A | ~$200 |
| **SDRPlay RSP1A** | 1k-2000 MHz | 10 MHz | 14 | ❌ | N/A | ~$110 |
| **SDRPlay RSPdx** | 1k-2000 MHz | 10 MHz | 14 | ❌ | N/A | ~$220 |
| **HackRF One** | 1-6000 MHz | 20 MHz | 8 | ✅ | Half | ~$300 |
| **PlutoSDR** | 325-3800 MHz* | 20 MHz | 12 | ✅ | Full | ~$150 |
| **LimeSDR Mini** | 10-3500 MHz | 30 MHz | 12 | ✅ | Full | ~$200 |
| **LimeSDR** | 100k-3800 MHz | 61 MHz | 12 | ✅ | Full | ~$300 |
| **BladeRF 2.0** | 47-6000 MHz | 56 MHz | 12 | ✅ | Full | ~$480 |
| **USRP B200** | 70-6000 MHz | 56 MHz | 12 | ✅ | Full | ~$1200 |
| **USRP B210** | 70-6000 MHz | 56 MHz | 12 | ✅ | Full | ~$2300 |

> *PlutoSDR can be firmware-hacked to 70-6000 MHz

---

## 🏗️ Architecture Types

### Direct Sampling vs Tuner

```
    DIRECT SAMPLING SDR                    TUNER-BASED SDR
    (e.g., RTL-SDR HF mode)               (e.g., RTL-SDR normal mode)
    
    ┌─────────┐   ┌─────┐                 ┌─────────┐   ┌──────┐   ┌─────┐
    │ Antenna │──▶│ ADC │──▶ Digital      │ Antenna │──▶│Tuner │──▶│ ADC │
    └─────────┘   └─────┘                 └─────────┘   │(R820T)│   └─────┘
                                                        └──────┘
    Pros: Simple, wideband               Pros: Covers VHF/UHF well
    Cons: Limited by ADC speed           Cons: Tuner limits range
```

### Half Duplex vs Full Duplex

The following table explains duplex modes:

| Mode | Description | Use Case |
|------|-------------|----------|
| **RX Only** | Receive only, no transmit | Monitoring, analysis |
| **Half Duplex** | TX or RX, not simultaneous | Packet radio, bursts |
| **Full Duplex** | TX and RX simultaneously | Repeaters, radar, comms |

---

## 🔌 Common Connectors

The following table shows RF connectors used by SDRs:

| Connector | Used By | Impedance | Max Freq |
|-----------|---------|-----------|----------|
| **SMA** | Most SDRs | 50Ω | 18 GHz |
| **MCX** | RTL-SDR v3 | 50Ω | 6 GHz |
| **Type A (USB)** | RTL-SDR | N/A | N/A |
| **Micro USB** | HackRF, many others | N/A | N/A |
| **USB-C** | Newer SDRs | N/A | N/A |

---

## ⚡ Power Considerations

The following table shows typical power consumption:

| SDR | Power Source | Current Draw |
|-----|--------------|--------------|
| RTL-SDR | USB | ~300 mA |
| HackRF | USB | ~500 mA |
| PlutoSDR | USB | ~500 mA |
| LimeSDR | USB | ~800 mA |
| USRP B200 | USB 3.0 | ~2 A |

---

## 📝 Specifications Explained

| Spec | Meaning | Why It Matters |
|------|---------|----------------|
| **Frequency Range** | Min-max tunable frequency | What signals you can receive |
| **Bandwidth** | Max instantaneous capture | How wide a view of spectrum |
| **Bits (ADC)** | Resolution of digitization | Dynamic range, sensitivity |
| **Sample Rate** | Samples per second | Related to bandwidth |
| **Noise Figure** | Added noise (dB) | Weak signal sensitivity |
| **TCXO** | Temp-compensated oscillator | Frequency stability |

---

*See individual hardware pages for detailed specifications and setup guides.*
