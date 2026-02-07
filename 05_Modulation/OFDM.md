# OFDM — Orthogonal Frequency Division Multiplexing

> **OFDM** - The multi-carrier modulation behind WiFi, LTE, 5G, DAB, and DVB-T.

---

## 1. Concept

Instead of one fast data stream, OFDM splits data across many slow parallel subcarriers:

```
    SINGLE CARRIER vs OFDM

    SINGLE CARRIER:
    │  ▐████████████████████████████████▌
    └──────────────────────────────────▶ f
         One wide, fast signal

    OFDM:
    │  ▐█▌▐█▌▐█▌▐█▌▐█▌▐█▌▐█▌▐█▌▐█▌▐█▌
    └──────────────────────────────────▶ f
         Many narrow, slow subcarriers
         (each QAM/PSK modulated)
```

---

## 2. Why OFDM?

| Advantage | Explanation |
|-----------|-------------|
| **Multipath resistant** | Slow symbol rate + guard interval handles reflections |
| **Spectral efficiency** | Subcarriers overlap (orthogonal = no interference) |
| **Adaptive modulation** | Each subcarrier can use different QAM order |
| **Simple equalization** | Per-subcarrier single-tap equalization |
| **Easy MIMO** | Extend to MIMO-OFDM naturally |

---

## 3. OFDM Generation (IFFT)

```
    OFDM TRANSMITTER

    Data bits ──▶ QAM Mapper ──▶ IFFT ──▶ Add Cyclic ──▶ DAC ──▶ RF
                     │                      Prefix
                     ▼
              Map bits to QAM
              symbols on each
              subcarrier
                     │
                     ▼
                ┌─────────┐
                │  IFFT   │  ← Converts frequency-domain
                │ (N-pt)  │     symbols to time-domain signal
                └─────────┘
```

---

## 4. OFDM Standards

| Standard | Application | Subcarriers | Subcarrier Spacing |
|----------|-------------|-------------|-------------------|
| WiFi 802.11a/g | WLAN 20 MHz | 52 (48 data) | 312.5 kHz |
| WiFi 802.11ax | WLAN | Up to 2048 | 78.125 kHz |
| LTE | Cellular | 72–1200 | 15 kHz |
| 5G NR | Cellular | Flexible | 15/30/60/120 kHz |
| DVB-T | Digital TV | 1705 (2K) or 6817 (8K) | ~1 kHz |
| DAB | Digital radio | 1536 | ~1 kHz |

---

## 5. Receiving OFDM with SDR

OFDM signals are too complex for simple AM/FM demod. You need:
- FFT-based receiver in GNU Radio
- Or specialized decoders (e.g., `gr-dvbt` for DVB-T, `srsRAN` for LTE)

---

*See also: [QAM](QAM.md) | [PSK](PSK.md) | [Back to 05_Modulation](README.md)*
