# Sampling Theory

> Nyquist theorem, aliasing, and sample rates — the bridge between analog RF and digital processing.

---

## 📖 Overview

Sampling is the process of converting a continuous-time analog signal into a
discrete-time digital signal by measuring its amplitude at regular intervals.

```
    SAMPLING PROCESS

    Analog Signal              Sampled Signal
    
    ▲                          ▲
    │   ╱╲                     │   │
    │  ╱  ╲    ╱╲              │   │  │
    │ ╱    ╲  ╱  ╲             │   │  │  │
    │╱      ╲╱    ╲            │   │  │  │  │
    └──────────────▶ t         └──┼──┼──┼──┼──▶ n
                                  T  2T 3T 4T
    
    T = sampling period = 1/fs
    fs = sampling frequency (samples/second)
```

---

## 🎯 Nyquist-Shannon Theorem

The fundamental theorem of digital signal processing:

$$f_s \geq 2 \cdot f_{max}$$

Where:
- $f_s$ = sampling frequency
- $f_{max}$ = highest frequency component in the signal

The minimum sampling rate $2 \cdot f_{max}$ is called the **Nyquist rate**.

### Practical Implication for SDR

| Signal | Highest Freq | Min Sample Rate | Typical SDR Rate |
|--------|-------------|-----------------|-----------------|
| FM Broadcast | 100 kHz baseband | 200 kSPS | 2.4 MSPS |
| ADS-B | 1 MHz | 2 MSPS | 2.4 MSPS |
| NFM Voice | 12.5 kHz | 25 kSPS | 250 kSPS |
| WiFi (20 MHz) | 10 MHz | 20 MSPS | 20+ MSPS |

---

## ⚠️ Aliasing

When you sample below the Nyquist rate, higher frequencies "fold back" and
appear as lower frequencies — this is **aliasing**.

```
    ALIASING DEMONSTRATION

    Real spectrum:
    Power
    ▲
    │  ▐█▌                    ▐█▌
    │  ▐█▌                    ▐█▌    ← Signal at f₁ > fs/2
    └──────────────────────────────▶ Freq
       f₀        fs/2         f₁

    What the ADC sees (aliased):
    Power
    ▲
    │  ▐█▌    ▐░▌
    │  ▐█▌    ▐░▌  ← Alias of f₁ appears at (fs - f₁)
    └──────────────────────────────▶ Freq
       f₀   fs-f₁   fs/2

    █ = Real signal    ░ = Alias (fake)
```

### Anti-Aliasing Filter

SDR hardware includes a **low-pass filter** before the ADC to remove
frequencies above $f_s/2$:

```
    ANTI-ALIAS FILTER IN SDR

    ┌─────────┐     ┌──────────┐     ┌─────┐
    │ Antenna │────▶│  LPF     │────▶│ ADC │──▶ Digital
    └─────────┘     │ (fc=fs/2)│     └─────┘
                    └──────────┘
                    Removes frequencies
                    above fs/2
```

---

## 📊 Sample Rate vs Bandwidth

In SDR, the usable bandwidth is approximately 80% of the sample rate
(due to filter roll-off at edges):

| Sample Rate | Usable BW | Good For |
|-------------|-----------|----------|
| 250 kSPS | ~200 kHz | Single FM station |
| 1 MSPS | ~800 kHz | Several FM stations |
| 2.4 MSPS | ~2 MHz | ADS-B, wide scan |
| 10 MSPS | ~8 MHz | Wideband analysis |
| 20 MSPS | ~16 MHz | WiFi channel |

---

## 🔢 Quantization

The ADC also **quantizes** each sample to a finite number of bits:

| ADC Bits | Levels | Dynamic Range | Example SDR |
|----------|--------|---------------|-------------|
| 8 | 256 | 48 dB | RTL-SDR |
| 12 | 4096 | 72 dB | PlutoSDR, LimeSDR |
| 14 | 16384 | 84 dB | SDRPlay RSP1A |
| 16 | 65536 | 96 dB | High-end receivers |

Dynamic range formula:

$$DR = 6.02 \times N + 1.76 \text{ dB}$$

Where N = number of ADC bits.

---

## 📐 Key Formulas

| Formula | Description |
|---------|-------------|
| $f_s \geq 2 f_{max}$ | Nyquist criterion |
| $f_{alias} = \|f_{signal} - n \cdot f_s\|$ | Alias frequency |
| $\Delta f = f_s / N$ | FFT frequency resolution |
| $DR = 6.02N + 1.76$ dB | ADC dynamic range |

---

## 🔗 Further Reading

- [01_Fundamentals/RF_Basics.md](RF_Basics.md) — RF propagation
- [01_Fundamentals/Quadrature_Signals.md](Quadrature_Signals.md) — I/Q sampling
- [04_DSP_Fundamentals/](../04_DSP_Fundamentals/README.md) — DSP operations on sampled data
- [dsp-tutorial-suite Ch02](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/02-sampling-and-aliasing.md) — Deep dive with C implementation
