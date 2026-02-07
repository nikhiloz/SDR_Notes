# SDRPlay RSP Series

> **SDRPlay** - Wideband, high-dynamic-range SDR receivers with excellent value.

---

## 1. Overview

SDRPlay receivers use the Mirics MSi2500 / MSi001 chipset, offering 1 kHz to 2 GHz coverage with 10 MHz bandwidth and 14-bit ADC — a significant step up from RTL-SDR.

---

## 2. Product Line

| Model | Freq Range | BW | ADC | Antenna Ports | Price |
|-------|------------|-----|-----|---------------|-------|
| **RSP1A** | 1 kHz – 2 GHz | 10 MHz | 14-bit | 1 (SMA) | ~$110 |
| **RSP1B** | 1 kHz – 2 GHz | 10 MHz | 14-bit | 1 (SMA) | ~$120 |
| **RSPdx** | 1 kHz – 2 GHz | 10 MHz | 14-bit | 3 (SMA) | ~$220 |
| **RSPduo** | 1 kHz – 2 GHz | 10 MHz | 14-bit | 3 (SMA), dual tuner | ~$280 |
| **RSPdx-R2** | 1 kHz – 2 GHz | 10 MHz | 14-bit | 3 (SMA) | ~$250 |

---

## 3. RSP1A (Best Value Entry)

```
    RSP1A BLOCK DIAGRAM

    ┌──────────────────────────────────────────────┐
    │                                               │
    │  Antenna (SMA)                                │
    │      │                                        │
    │      ▼                                        │
    │  ┌─────────┐   ┌──────────┐   ┌──────────┐  │
    │  │ Presel. │──▶│ MSi001   │──▶│ MSi2500  │──▶ USB 2.0
    │  │ Filters │   │ RF Tuner │   │ 14-bit   │  │
    │  └─────────┘   └──────────┘   │ ADC+DSP  │  │
    │                                └──────────┘  │
    │                                               │
    │  Coverage: 1 kHz – 2 GHz (no gaps)           │
    └──────────────────────────────────────────────┘
```

---

## 4. Key Advantages

| Feature | Benefit |
|---------|---------|
| 1 kHz start | Covers LF, MF, HF — no upconverter needed |
| 14-bit ADC | Superior dynamic range vs 8-bit RTL-SDR |
| 10 MHz BW | See wider chunk of spectrum at once |
| No gaps | Continuous coverage, no blind spots |
| Built-in filters | Preselection reduces intermod |

---

## 5. Software Support

| Software | Support | Notes |
|----------|---------|-------|
| SDRuno | ✅ (native) | Windows, full featured |
| SDR++ | ✅ | Cross-platform |
| CubicSDR | ✅ | Via SoapySDR |
| GNU Radio | ✅ | Via gr-soapy + SoapySDRPlay3 |
| GQRX | ✅ | Via SoapySDR |
| SDRangel | ✅ | Direct support |

### Linux Setup

```bash
# Install SDRPlay API (download from sdrplay.com)
chmod +x SDRplay_RSP_API-Linux-3.x.x.run
sudo ./SDRplay_RSP_API-Linux-3.x.x.run

# Install SoapySDRPlay3
sudo apt install soapysdr-module-sdrplay3

# Verify
SoapySDRUtil --find
```

---

## 6. RSPduo (Dual Tuner)

The RSPduo has **two independent tuners** sharing the same clock — enabling:
- Diversity reception (same signal, two antennas)
- Simultaneous monitoring of two different frequencies
- Phase-coherent reception experiments

---

*See also: [Hardware Comparison](Hardware_Comparison.md) | [Back to 02_Hardware](README.md)*
