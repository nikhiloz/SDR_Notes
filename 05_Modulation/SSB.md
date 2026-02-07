# Single Sideband (SSB)

> **SSB** - The most bandwidth-efficient analog voice modulation, widely used on HF.

---

## 1. Overview

SSB removes the carrier and one sideband from an AM signal, leaving only the useful information in half the bandwidth:

```
    AM (DSB-FC)                    SSB (USB shown)

    │     ▐█▌  carrier             │        ▐█▌
    │   ▐████▌                     │       ▐████▌
    │  ▐██████▌                    │      ▐██████▌
    │ ▐████████▌                   │     ▐████████▌
    └────┼────────▶ f              └────────────────▶ f
      LSB  C  USB                        USB only

    BW: 2 × f_audio                BW: f_audio (~3 kHz)
```

---

## 2. USB vs LSB Convention

| Mode | Sideband Kept | Typical Use |
|------|--------------|-------------|
| **USB** (Upper) | Above carrier | 10 MHz+ amateur, marine, aviation HF |
| **LSB** (Lower) | Below carrier | Below 10 MHz amateur bands |

---

## 3. Demodulation

SSB requires a **Beat Frequency Oscillator (BFO)** — in SDR, this is just a software oscillator:

$$\text{audio}(t) = \text{LPF}\{s(t) \cdot \cos(2\pi f_{BFO} t)\}$$

In SDR software: select USB or LSB mode and the software handles the BFO automatically.

---

## 4. SDR Settings for SSB

| Parameter | Value |
|-----------|-------|
| Mode | USB or LSB |
| Filter BW | 2.4–3.0 kHz |
| AGC | Medium or Slow |
| Squelch | Off (SSB has no carrier to detect) |

---

*See also: [AM Demodulation](AM_Demodulation.md) | [FM Demodulation](FM_Demodulation.md) | [Back to 05_Modulation](README.md)*
