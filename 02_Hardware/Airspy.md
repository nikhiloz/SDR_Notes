# Airspy SDR Receivers

> **Airspy** - High-dynamic-range SDR receivers for demanding applications.

---

## 1. Overview

Airspy produces some of the highest quality SDR receivers available. The product line spans from compact VHF/UHF receivers to dedicated HF units.

---

## 2. Product Line

### 2.1 Airspy Mini

| Parameter | Value |
|-----------|-------|
| **Freq Range** | 24–1800 MHz |
| **Bandwidth** | 6 MHz |
| **ADC** | 12-bit |
| **Dynamic Range** | 12-bit equivalent |
| **Interface** | USB 2.0 |
| **Price** | ~$100 |
| **Best For** | High-quality VHF/UHF reception |

### 2.2 Airspy R2

| Parameter | Value |
|-----------|-------|
| **Freq Range** | 24–1800 MHz |
| **Bandwidth** | 10 MHz |
| **ADC** | 12-bit |
| **Interface** | USB 2.0 |
| **Price** | ~$170 |
| **Best For** | Wideband monitoring |

### 2.3 Airspy HF+ Discovery

| Parameter | Value |
|-----------|-------|
| **Freq Range** | 0.5 kHz – 31 MHz, 60–260 MHz |
| **Bandwidth** | 768 kHz |
| **ADC** | 18-bit equivalent (oversampling) |
| **Interface** | USB 2.0 |
| **Price** | ~$170 |
| **Best For** | HF reception, shortwave, amateur radio |

---

## 3. Key Technology

```
    AIRSPY ARCHITECTURE (Simplified)

    ┌──────────────────────────────────────────────────┐
    │                                                   │
    │  ┌─────────┐   ┌─────────┐   ┌───────────────┐  │
    │  │ R820T2  │──▶│ LPC4370 │──▶│  USB 2.0      │──▶ PC
    │  │ Tuner   │   │ ARM M4  │   │  Interface    │  │
    │  └─────────┘   │ 12-bit  │   └───────────────┘  │
    │                 │ 80 MSPS │                       │
    │                 └─────────┘                       │
    │                                                   │
    │  Key: Oversampling + decimation = higher ENOB     │
    └──────────────────────────────────────────────────┘
```

Airspy uses **oversampling and decimation** to achieve dynamic range beyond the raw ADC bits — the Mini's 12-bit ADC at 80 MSPS, decimated to 6 MSPS, yields ~16-bit equivalent performance.

---

## 4. Software Support

| Software | Support |
|----------|---------|
| SDR# | ✅ (native, same company) |
| SDR++ | ✅ |
| GQRX | ✅ via SoapySDR |
| GNU Radio | ✅ via gr-osmosdr / SoapySDR |
| SpyServer | ✅ (native remote streaming) |

---

## 5. SpyServer (Remote Streaming)

Airspy's SpyServer allows low-bandwidth remote access:

```bash
# On the server (where SDR is connected)
./spyserver spyserver.config

# On client
# Open SDR# → connect to spyserver://server-ip:5555
```

Bandwidth requirement: **much less** than raw I/Q — SpyServer sends only the visible/selected bandwidth.

---

## 6. Comparison with RTL-SDR

| Feature | RTL-SDR v3 | Airspy Mini |
|---------|-----------|-------------|
| Dynamic Range | ~50 dB | ~80 dB |
| ADC Bits | 8 | 12 (16 effective) |
| Spurious-free DR | Fair | Excellent |
| Sensitivity | Good | Better |
| Strong signal handling | Poor | Excellent |
| Price | $30 | $100 |

---

*See also: [Hardware Comparison](Hardware_Comparison.md) | [Back to 02_Hardware](README.md)*
