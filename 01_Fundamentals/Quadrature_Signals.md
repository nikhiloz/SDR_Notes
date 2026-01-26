# Quadrature Signals (I/Q Data)

> **I/Q Signals** - The complex representation at the heart of every SDR.

---

## 1. Overview

### 1.1 What Are I/Q Signals?

Every SDR outputs **I/Q samples** - pairs of numbers representing the In-phase (I) and Quadrature (Q) components of a signal. Together they form a **complex signal** that captures both amplitude AND phase information.

The following diagram shows the I/Q representation concept:

```
┌──────────────────────────────────────────────────────────────────────────┐
│                         I/Q SIGNAL REPRESENTATION                         │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│                    Q (Quadrature)                                         │
│                    90°                                                    │
│                    │                                                      │
│                    │      ╱ Signal Vector                                │
│                    │    ╱   A = Amplitude                                │
│                    │  ╱     φ = Phase                                    │
│                    │╱ φ                                                   │
│   ─────────────────┼─────────────────▶ I (In-phase) 0°                   │
│                    │                                                      │
│                    │                                                      │
│                    │                                                      │
│                    270°                                                   │
│                                                                           │
│   Complex Sample:  s = I + jQ                                            │
│   Amplitude:       A = √(I² + Q²)                                        │
│   Phase:           φ = atan2(Q, I)                                       │
│                                                                           │
└──────────────────────────────────────────────────────────────────────────┘
```

### 1.2 Why Not Just Real Samples?

The following table explains why SDRs use I/Q (complex) samples:

| Problem with Real Samples | I/Q Solution |
|---------------------------|--------------|
| Cannot distinguish +/- frequencies relative to LO | I/Q naturally represents positive and negative frequencies |
| Lose phase information | Phase preserved in I/Q relationship |
| "Image" frequency appears | No image with proper I/Q |
| Need 2× bandwidth for same info | Full information in I/Q samples |

---

## 2. Generating I/Q Signals

### 2.1 Quadrature Mixer

SDRs use a **quadrature mixer** to generate I/Q. The RF signal is mixed with two versions of the local oscillator 90° apart:

```
                    QUADRATURE MIXER (I/Q GENERATION)
                    
    RF Input ─────────────┬─────────────────────────────────────┐
                          │                                     │
                          ▼                                     ▼
                    ┌──────────┐                          ┌──────────┐
                    │  Mixer   │                          │  Mixer   │
                    │    I     │                          │    Q     │
                    └────┬─────┘                          └────┬─────┘
                         │                                     │
                         │                                     │
              ┌──────────┴──────────┐             ┌───────────┴──────────┐
              │                     │             │                      │
              ▼                     │             ▼                      │
          ┌───────┐                 │         ┌───────┐                  │
          │  LPF  │                 │         │  LPF  │                  │
          └───┬───┘                 │         └───┬───┘                  │
              │                     │             │                      │
              ▼                     │             ▼                      │
          ┌───────┐                 │         ┌───────┐                  │
          │  ADC  │                 │         │  ADC  │                  │
          └───┬───┘                 │         └───┬───┘                  │
              │                     │             │                      │
              ▼                     │             ▼                      │
         I samples                  │        Q samples                   │
                                    │                                    │
                              ┌─────┴─────┐                              │
                              │    LO     │◀─────────────────────────────┘
                              │   0° 90°  │
                              │   (NCO)   │
                              └───────────┘
                              
    LO at 0° mixes with RF → I component
    LO at 90° mixes with RF → Q component
```

### 2.2 Mathematical Basis

The RF signal can be written as:
$$s_{RF}(t) = A(t) \cos(2\pi f_c t + \phi(t))$$

Mixing with LO at 0° and 90°:
$$I(t) = A(t) \cos(\phi(t))$$
$$Q(t) = A(t) \sin(\phi(t))$$

Combined as complex:
$$s(t) = I(t) + j \cdot Q(t) = A(t) e^{j\phi(t)}$$

---

## 3. I/Q Data Format

### 3.1 Sample Format

SDRs output I/Q samples as interleaved pairs:

```
    I/Q SAMPLE STREAM
    
    ┌────┬────┬────┬────┬────┬────┬────┬────┬────┬────┐
    │ I₀ │ Q₀ │ I₁ │ Q₁ │ I₂ │ Q₂ │ I₃ │ Q₃ │ ... │    │
    └────┴────┴────┴────┴────┴────┴────┴────┴────┴────┘
      └──┬──┘   └──┬──┘   └──┬──┘   └──┬──┘
      Sample 0  Sample 1  Sample 2  Sample 3
      
    Each "sample" is actually a complex number (I + jQ)
```

### 3.2 Common Data Types

The following table shows common I/Q sample formats:

| Format | Bits per I or Q | Bytes per Complex Sample | Example SDR |
|--------|-----------------|--------------------------|-------------|
| **8-bit unsigned** | 8 | 2 | RTL-SDR |
| **8-bit signed** | 8 | 2 | HackRF |
| **12-bit signed** | 12 (packed) | 3 | Airspy, LimeSDR |
| **16-bit signed** | 16 | 4 | PlutoSDR, USRP |
| **32-bit float** | 32 | 8 | GNU Radio internal |

### 3.3 8-bit Unsigned (RTL-SDR)

RTL-SDR uses unsigned 8-bit samples:

| Raw Value | Meaning |
|-----------|---------|
| 0 | Minimum (most negative) |
| 127-128 | Zero (DC) |
| 255 | Maximum (most positive) |

To convert to signed: `signed = unsigned - 127`

---

## 4. Extracting Signal Information

### 4.1 From I/Q to Amplitude and Phase

The following table shows how to extract signal parameters:

| Parameter | Formula | Description |
|-----------|---------|-------------|
| **Amplitude** | $A = \sqrt{I^2 + Q^2}$ | Signal envelope |
| **Phase** | $\phi = \arctan2(Q, I)$ | Instantaneous phase |
| **Frequency** | $f = \frac{1}{2\pi} \cdot \frac{d\phi}{dt}$ | Instantaneous frequency |
| **Power** | $P = I^2 + Q^2$ | Signal power (no sqrt) |

### 4.2 Phase Unwrapping

Phase from atan2 wraps at ±π. For frequency detection, we need to unwrap:

```
    PHASE WRAPPING
    
    Raw Phase (wrapped)              Unwrapped Phase
          π │      ╱│╲                    │           ╱
            │     ╱ │ ╲                   │          ╱
            │    ╱  │  ╲                  │         ╱
            │   ╱   │   ╲                 │        ╱
         0  ├──╱────┼────╲───▶ t          │       ╱
            │ ╱     │     ╲               │      ╱
            │╱      │      ╲              │     ╱
         -π │       │       ╲             │    ╱
                                          ├───╱────────▶ t
            Discontinuities              Continuous
            at ±π                        (actual phase)
```

---

## 5. Frequency Representation

### 5.1 Positive and Negative Frequencies

I/Q allows representing frequencies above AND below the center frequency:

```
    FREQUENCY REPRESENTATION WITH I/Q
    
    DC (0 Hz)        Positive Frequencies
        │                  ▲
        │                  │
        │    ╭─────────────┴─────────────╮
        │    │                           │
    ────┼────┼───────────────────────────┼────▶ Frequency
        │    │                           │
        │    ╰─────────────┬─────────────╯
        │                  │
        │                  ▼
              Negative Frequencies
              
    With I/Q samples at sample rate Fs:
    - Representable range: -Fs/2 to +Fs/2
    - Centered at LO frequency
    
    Real samples only: 0 to Fs/2 (positive only, with images)
```

### 5.2 Frequency Offset

If tuned to 100 MHz and receive a signal at 100.1 MHz:

- Center frequency: 100 MHz (appears at DC/0 Hz in baseband)
- Signal at 100.1 MHz: Appears at +100 kHz in baseband
- Signal at 99.9 MHz: Appears at -100 kHz in baseband

---

## 6. I/Q Impairments

### 6.1 Common Issues

Real hardware has imperfections that affect I/Q quality:

```
    I/Q IMPAIRMENTS
    
    IDEAL                       DC OFFSET                    I/Q IMBALANCE
    
         Q                           Q                            Q
         │                           │                            │
         │     ●                     │     ●                      │   ●
         │    ╱│                     │    ╱│                      │  /
         │   ╱ │                     │   ╱ │                      │ /
    ─────┼──●──┼─── I           ─────┼──●──┼─── I           ─────┼●────── I
         │   ╲ │                     │╲  ╲ │                      │ \
         │    ╲│                     │ ╲  ╲│                      │  \
         │     ●                     │  ╲  ●                      │   ●
         │                           │   ╲                        │
                                     │    ● Offset               Ellipse not
    Circle centered                  Center shifted              circle
    at origin                        from origin                 (gain/phase
                                                                  mismatch)
```

### 6.2 Impairment Effects

The following table describes I/Q impairments and their effects:

| Impairment | Cause | Effect | Mitigation |
|------------|-------|--------|------------|
| **DC Offset** | LO leakage, ADC offset | Spike at center freq | DC blocking, calibration |
| **Gain Imbalance** | Unequal I/Q amplifiers | Image signal | Calibration |
| **Phase Imbalance** | Not exactly 90° | Image signal | Calibration |
| **Sample Clock Offset** | I/Q sampled at different times | Frequency-dependent error | Hardware design |

---

## 7. Working with I/Q in Software

### 7.1 Python Example

```python
import numpy as np

# Read RTL-SDR samples (8-bit unsigned, interleaved I/Q)
raw = np.fromfile('capture.bin', dtype=np.uint8)

# Convert to complex float
i = raw[0::2] - 127.5  # Even indices = I
q = raw[1::2] - 127.5  # Odd indices = Q
iq = i + 1j * q        # Complex signal

# Calculate amplitude (envelope)
amplitude = np.abs(iq)  # = sqrt(I² + Q²)

# Calculate phase
phase = np.angle(iq)    # = atan2(Q, I)

# Calculate power spectrum (FFT)
spectrum = np.fft.fftshift(np.fft.fft(iq))
power_db = 20 * np.log10(np.abs(spectrum))
```

### 7.2 GNU Radio

In GNU Radio, I/Q data flows as `complex` type:

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  SDR Source  │────▶│   Filter     │────▶│ Demodulator  │
│ (complex)    │     │ (complex)    │     │              │
└──────────────┘     └──────────────┘     └──────────────┘
                           │
                    Complex I/Q samples
                    flow through blocks
```

---

## 8. Visualizing I/Q

### 8.1 Constellation Diagram

The constellation shows I/Q points over time - essential for digital modulation:

```
    CONSTELLATION DIAGRAMS
    
    BPSK (2 states)         QPSK (4 states)         16-QAM (16 states)
    
         Q                       Q                       Q
         │                       │                       │
         │                       │  ●       ●            │  ● ● ● ●
         │                       │                       │  ● ● ● ●
    ●────┼────● I           ●────┼────● I           ────┼──────── I
         │                       │                       │  ● ● ● ●
         │                       │  ●       ●            │  ● ● ● ●
         │                       │                       │
         
    Each dot = valid symbol position
    More dots = more bits per symbol = higher data rate
```

### 8.2 Spectrogram/Waterfall

The waterfall shows spectrum over time, colored by power:

```
    WATERFALL DISPLAY
    
    Time     Frequency ─────────────────────────────▶
      │      │░░░░░░░░░████████░░░░░░░░░░░░░░░░░░░│  
      │      │░░░░░░░░░████████░░░░░░░░░░░░░░░░░░░│  Signal present
      ▼      │░░░░░░░░░████████░░░░░░░░░░░░░░░░░░░│
             │░░░░░░░░░████████░░░░░░░░░░░░░░░░░░░│
             │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│  No signal
             │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│
             
    Dark = low power (noise floor)
    Bright = high power (signal)
```

---

## 9. Summary

The following table summarizes key I/Q concepts:

| Concept | Key Point |
|---------|-----------|
| **I/Q** | Complex representation: I + jQ |
| **I** | In-phase component (0°) |
| **Q** | Quadrature component (90°) |
| **Amplitude** | √(I² + Q²) |
| **Phase** | atan2(Q, I) |
| **Why I/Q** | Captures amplitude AND phase, distinguishes +/- frequencies |
| **Format** | Interleaved I,Q,I,Q,... samples |
| **Impairments** | DC offset, I/Q imbalance cause artifacts |

---

## 10. Key Formulas

$$s(t) = I(t) + j \cdot Q(t)$$

$$A(t) = \sqrt{I(t)^2 + Q(t)^2}$$

$$\phi(t) = \arctan2(Q(t), I(t))$$

$$f_{inst}(t) = \frac{1}{2\pi} \frac{d\phi(t)}{dt}$$

---

*Next: [Decibels_Power.md](Decibels_Power.md) - Power measurements in RF*
