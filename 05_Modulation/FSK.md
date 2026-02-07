# Frequency Shift Keying (FSK)

> **FSK** - Digital modulation that encodes data by shifting between discrete frequencies.

---

## 1. Concept

```
    2-FSK (Binary FSK)

    Data:      1    0    1    1    0    0    1

    Signal:   ╱╲╱╲ ╱╲╱ ╱╲╱╲ ╱╲╱╲ ╱╲╱ ╱╲╱ ╱╲╱╲
              f₁   f₀  f₁   f₁   f₀  f₀  f₁
              high  low high  high low low  high

    '1' = higher frequency (mark)
    '0' = lower frequency (space)
```

---

## 2. FSK Variants

| Variant | Description | Use Case |
|---------|-------------|----------|
| **2-FSK** | Two frequencies | Simple digital |
| **4-FSK** | Four frequencies (2 bits/symbol) | DMR, P25 Phase II |
| **GFSK** | Gaussian-filtered FSK (smooth transitions) | Bluetooth, DECT |
| **AFSK** | Audio FSK (tones over voice channel) | APRS (1200/2200 Hz) |
| **MSK** | Minimum shift — continuous phase | Efficient spectrum use |
| **GMSK** | Gaussian MSK | GSM cellular |

---

## 3. Demodulation

FSK can be demodulated using:
1. **FM discriminator** — treat as FM, then threshold/slice
2. **Matched filters** — correlate with expected mark/space waveforms
3. **Zero-crossing counting** — count zero crossings per symbol period

In SDR: FM demodulate → low-pass filter → binary slicer → clock recovery → bits

---

## 4. SDR Reception

```bash
# Receive and demodulate FSK with rtl_fm
rtl_fm -f 433920000 -s 250000 -r 48000 | sox -t raw -r 48000 -e signed -b 16 - -t wav output.wav
```

---

## 5. Common FSK Signals

| Signal | Frequencies | Baud Rate | Tool |
|--------|------------|-----------|------|
| POCSAG (pagers) | 152/454 MHz | 512/1200/2400 | multimon-ng |
| AFSK 1200 (APRS) | 1200/2200 Hz tones on VHF | 1200 | Direwolf |
| Bluetooth (GFSK) | 2.4 GHz ISM | 1 Mbps | — |
| 433 MHz sensors | 433.92 MHz | Various | rtl_433 |

---

*See also: [PSK](PSK.md) | [QAM](QAM.md) | [Back to 05_Modulation](README.md)*
