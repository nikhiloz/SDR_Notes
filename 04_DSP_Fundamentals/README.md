# 04_DSP_Fundamentals

> **Digital Signal Processing** - Core DSP concepts for SDR applications.

---

## 📖 Contents

| Document | Description |
|----------|-------------|
| [DSP_Overview.md](DSP_Overview.md) | Introduction to DSP |
| [Filters.md](Filters.md) | LPF, HPF, BPF, Notch filters |
| [FIR_Filters.md](FIR_Filters.md) | Finite Impulse Response |
| [IIR_Filters.md](IIR_Filters.md) | Infinite Impulse Response |
| [FFT_Spectrum.md](FFT_Spectrum.md) | Fast Fourier Transform |
| [Decimation_Interpolation.md](Decimation_Interpolation.md) | Sample rate conversion |
| [AGC.md](AGC.md) | Automatic Gain Control |

---

## 🎯 DSP Overview

### What is DSP?

Digital Signal Processing is the mathematical manipulation of signals represented as sequences of numbers. In SDR, DSP replaces traditional analog circuits.

The following diagram shows DSP in the SDR context:

```
    DSP IN SDR
    
    ┌─────────────────────────────────────────────────────────────────────────┐
    │                                                                          │
    │  ANALOG                              DIGITAL                             │
    │  ────────                            ───────                             │
    │                                                                          │
    │  ┌─────────┐   ┌─────┐              ┌────────────────────────────────┐  │
    │  │ Antenna │──▶│ ADC │─────────────▶│           DSP                  │  │
    │  └─────────┘   └─────┘              │                                │  │
    │                   │                  │  ┌────────┐   ┌────────────┐  │  │
    │                   │                  │  │Filtering│──▶│Demodulation│  │  │
    │              I/Q samples             │  └────────┘   └────────────┘  │  │
    │              at sample rate          │       │              │        │  │
    │                                      │       ▼              ▼        │  │
    │                                      │  ┌────────┐   ┌────────────┐  │  │
    │                                      │  │Resample│   │  Decoding  │  │  │
    │                                      │  └────────┘   └────────────┘  │  │
    │                                      └────────────────────────────────┘  │
    │                                                                          │
    └─────────────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Key DSP Operations

### Common Operations in SDR

The following table lists essential DSP operations:

| Operation | Purpose | Example |
|-----------|---------|---------|
| **Filtering** | Remove unwanted frequencies | Isolate channel |
| **Decimation** | Reduce sample rate | 2 MSPS → 200 kSPS |
| **Interpolation** | Increase sample rate | 8 kHz → 48 kHz |
| **Mixing** | Shift frequency | Tune to channel |
| **FFT** | View spectrum | Waterfall display |
| **Demodulation** | Extract information | AM, FM, PSK |
| **AGC** | Normalize amplitude | Handle varying signals |

---

## 📊 Filtering

### Filter Types

The following diagram shows filter frequency responses:

```
    FILTER TYPES
    
    LOW-PASS (LPF)              HIGH-PASS (HPF)
    
    Gain │████████               Gain │        ████████
         │████████                    │        ████████
         │████████                    │        ████████
         │████████▓▓                  │      ▓▓████████
         │████████░░░                 │   ░░░████████
         └────────────▶ Freq          └────────────▶ Freq
              fc                           fc
         
    BAND-PASS (BPF)              NOTCH (BAND-STOP)
    
    Gain │    ████████           Gain │████████    ████████
         │    ████████                │████████    ████████
         │    ████████                │████████    ████████
         │  ▓▓████████▓▓              │████████▓▓▓▓████████
         │░░░████████░░░              │████████░░░░████████
         └────────────▶ Freq          └────────────▶ Freq
            f1    f2                      f1    f2
```

### Filter Parameters

| Parameter | Description |
|-----------|-------------|
| **Cutoff (fc)** | Frequency where filter starts attenuating |
| **Passband** | Frequencies that pass through |
| **Stopband** | Frequencies that are blocked |
| **Transition** | Roll-off region between pass and stop |
| **Ripple** | Variation in passband response |
| **Order** | Complexity (higher = sharper) |

---

## 📈 FFT and Spectrum

### Fast Fourier Transform

The FFT converts time-domain samples to frequency-domain:

```
    TIME DOMAIN  ────FFT────▶  FREQUENCY DOMAIN
    
    Amplitude                  Power
        │   ╱╲                    │
        │  ╱  ╲                   │     ▐█▌
        │ ╱    ╲                  │     ▐█▌
        │╱      ╲                 │   ▐▌▐█▌▐▌
        └────────▶ Time           └────────────▶ Freq
    
    N samples in → N/2 + 1 frequency bins out
```

### FFT Size vs Resolution

| FFT Size | Freq Resolution (at 2 MSPS) | Update Rate |
|----------|----------------------------|-------------|
| 256 | 7.8 kHz | Fast |
| 1024 | 1.95 kHz | Medium |
| 4096 | 488 Hz | Slow |
| 16384 | 122 Hz | Very slow |

$$\text{Resolution} = \frac{\text{Sample Rate}}{\text{FFT Size}}$$

---

## ⬇️ Decimation and Resampling

### Decimation

Reducing sample rate by factor M:

```
    DECIMATION BY 4
    
    Input:  ●─●─●─●─●─●─●─●─●─●─●─●─●─●─●─●  (16 samples)
                        ↓
    LPF:    ●─●─●─●─●─●─●─●─●─●─●─●─●─●─●─●  (anti-alias filter)
                        ↓
    Output: ●───────●───────●───────●        (4 samples)
    
    Rate: Fs → Fs/4
```

### Why Decimate?

| Reason | Benefit |
|--------|---------|
| Reduce data rate | Less CPU, disk space |
| Match audio rate | 2 MSPS → 48 kHz |
| Reduce noise | LPF removes out-of-band noise |
| Easier processing | Lower rate = less work |

---

## 🎚️ Automatic Gain Control (AGC)

### AGC Purpose

Normalize signal amplitude despite varying input levels:

```
    WITHOUT AGC                    WITH AGC
    
    Input:  ─╱╲───────╱╲╲╲╲───     Input:  ─╱╲───────╱╲╲╲╲───
               │         │                    │         │
               │         │                    ▼         ▼
    Output: ─╱╲───────╱╲╲╲╲───     Output: ─╱╲───────╱╲─────
                                           (normalized)
               Weak      Strong              Even      Even
```

### AGC Parameters

| Parameter | Description |
|-----------|-------------|
| **Attack** | How fast AGC responds to increase |
| **Decay** | How fast AGC responds to decrease |
| **Reference** | Target output level |
| **Max Gain** | Maximum amplification |

---

## 📐 Key Formulas

### Decibels
$$\text{dB} = 10 \log_{10}\left(\frac{P_{out}}{P_{in}}\right)$$

### FFT Resolution
$$\Delta f = \frac{f_s}{N}$$

### Decimation Output Rate
$$f_{out} = \frac{f_{in}}{M}$$

### Filter Order (FIR)
$$N \approx \frac{4}{\text{Transition Width / Sample Rate}}$$

---

## 🛠️ DSP in GNU Radio

Common DSP blocks in GNU Radio:

| Block | Function |
|-------|----------|
| Low Pass Filter | Remove high frequencies |
| Band Pass Filter | Keep frequency range |
| Rational Resampler | Change sample rate |
| FFT | Spectrum analysis |
| AGC | Amplitude normalization |
| Frequency Xlating FIR | Tune + filter combined |

---

*See individual topic pages for detailed explanations.*
