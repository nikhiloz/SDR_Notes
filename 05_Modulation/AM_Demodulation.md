# AM Demodulation

> **Amplitude Modulation** - Understanding and implementing AM demodulation.

---

## 📖 Contents

| Section | Description |
|---------|-------------|
| [Overview](#-overview) | What is AM |
| [Theory](#-am-theory) | How AM works |
| [Demodulation](#-demodulation-methods) | Envelope detection, synchronous |
| [GNU Radio](#-gnu-radio-implementation) | Practical flowgraph |
| [DSP Math](#-mathematical-background) | Formulas |

---

## 📻 Overview

### What is AM?

Amplitude Modulation encodes information in the varying amplitude of a carrier wave. It's one of the oldest and simplest modulation techniques.

The following diagram shows AM signal structure:

```
    AMPLITUDE MODULATION
    
    CARRIER (Unmodulated)          MODULATING SIGNAL (Audio)
    
     ╱╲  ╱╲  ╱╲  ╱╲  ╱╲               ╱────╲
    ╱  ╲╱  ╲╱  ╲╱  ╲╱  ╲            ╱        ╲
                                   ╱          ╲
    Constant amplitude                        Audio
                                              waveform
    
                         ↓ Modulation ↓
    
    AM SIGNAL (Modulated Carrier)
    
        ╱╲   ╱╲   ╱╲                       Envelope
       ╱  ╲ ╱  ╲ ╱  ╲     ╱╲╲              follows
      ╱    ╲    ╲    ╲   ╱    ╲            audio
     ╱      ╲    ╲    ╲ ╱      ╲
    ╱        ╲    ╲    ╳        ╲
             ▼    ▼   ▼ ▼        ▼
    ─────────────────────────────────▶ Time
    
    The envelope (outline) contains the audio information
```

---

## 📊 AM Theory

### AM Signal Components

| Component | Description |
|-----------|-------------|
| **Carrier** | Main RF frequency (fc) |
| **Upper Sideband** | fc + audio frequencies |
| **Lower Sideband** | fc - audio frequencies |
| **Modulation Index** | Depth of modulation (0-1) |

### Frequency Spectrum

```
    AM SPECTRUM
    
    Power
    ▲
    │           ┌─────┐
    │           │     │
    │           │     │         Carrier (fc)
    │           │     │
    │     ┌───┐ │     │ ┌───┐
    │     │   │ │     │ │   │   Sidebands
    │     │   │ │     │ │   │
    └─────┴───┴─┴─────┴─┴───┴────────▶ Frequency
          │     │     │     │
         LSB    fc   USB
          │◄─────────────►│
               Bandwidth
           = 2 × max audio freq
```

### Bandwidth Calculation

$$BW_{AM} = 2 \times f_{audio,max}$$

| Audio Range | AM Bandwidth |
|-------------|--------------|
| 3 kHz (voice) | 6 kHz |
| 5 kHz (broadcast) | 10 kHz |
| 10 kHz (hi-fi AM) | 20 kHz |

---

## 🔧 Demodulation Methods

### 1. Envelope Detection

The simplest method - extract the envelope:

```
    ENVELOPE DETECTION
    
    Step 1: Rectify (remove negative half)
    
    Input AM:   ╱╲╱╲╱╲╱╲╱╲╱╲╱╲     Rectified: ╱╲╱╲╱╲╱╲╱╲
               ╲╱╲╱╲╱╲╱╲╱╲╱╲╱               ▔▔▔▔▔▔▔▔▔▔
    
    Step 2: Low-pass filter (extract envelope)
    
    Rectified:  ╱╲╱╲╱╲╱╲╱╲              Filtered:  ─────╲
                                                        ╲────
    
    Result: Original audio recovered!
```

### Envelope Detector Block Diagram

```
    ┌──────────┐     ┌──────────┐     ┌──────────┐
    │  AM      │────▶│ Rectifier│────▶│ Low-Pass │────▶ Audio
    │ Signal   │     │ |x|      │     │ Filter   │      Out
    └──────────┘     └──────────┘     └──────────┘
```

### 2. Synchronous Detection

More complex but better quality:

```
    SYNCHRONOUS DETECTION
    
    ┌────────────┐     ┌────────────┐     ┌────────────┐
    │   AM       │────▶│  Multiply  │────▶│  Low-Pass  │──▶ Audio
    │  Signal    │     │            │     │  Filter    │
    └────────────┘     └─────┬──────┘     └────────────┘
                             │
                             │
                       ┌─────┴──────┐
                       │   Local    │
                       │ Oscillator │
                       │  (at fc)   │
                       └────────────┘
    
    LO must be phase-locked to carrier!
```

### Method Comparison

| Method | Complexity | Quality | Use Case |
|--------|------------|---------|----------|
| Envelope | Simple | Good | Standard AM |
| Synchronous | Complex | Better | Weak signals, SSB |

---

## 🛠️ GNU Radio Implementation

### Simple AM Receiver Flowgraph

```
    GNU RADIO AM RECEIVER
    
    ┌────────────┐     ┌────────────┐     ┌────────────┐
    │  RTL-SDR   │────▶│  Low-Pass  │────▶│  Resample  │
    │  Source    │     │  Filter    │     │  (Decimate)│
    │ 1.2 MSPS   │     │  10 kHz    │     │            │
    └────────────┘     └────────────┘     └─────┬──────┘
                                                │
         ┌──────────────────────────────────────┘
         │
         ▼
    ┌────────────┐     ┌────────────┐     ┌────────────┐
    │  Complex   │────▶│  Multiply  │────▶│  Low-Pass  │
    │    to      │     │  Constant  │     │  Filter    │
    │ Magnitude  │     │  (Volume)  │     │  (Audio)   │
    └────────────┘     └────────────┘     └─────┬──────┘
                                                │
         ┌──────────────────────────────────────┘
         │
         ▼
    ┌────────────┐
    │   Audio    │
    │   Sink     │
    │  48 kHz    │
    └────────────┘
```

### Key Blocks

| Block | Purpose | Parameters |
|-------|---------|------------|
| RTL-SDR Source | Input | fc, sample_rate |
| Low-Pass Filter | Channel select | 10 kHz cutoff |
| Rational Resampler | Rate conversion | To ~48 kSPS |
| Complex to Mag | Envelope detect | None |
| Multiply Const | Volume | 0.0 to 1.0 |
| Audio Sink | Output | 48000 Hz |

---

## 📐 Mathematical Background

### AM Signal Equation

$$s(t) = A_c [1 + m \cdot x(t)] \cos(2\pi f_c t)$$

Where:
- $A_c$ = Carrier amplitude
- $m$ = Modulation index (0 to 1)
- $x(t)$ = Audio signal (-1 to +1)
- $f_c$ = Carrier frequency

### Modulation Index

$$m = \frac{A_{max} - A_{min}}{A_{max} + A_{min}}$$

| Modulation Index | Result |
|------------------|--------|
| m < 1 | Normal AM |
| m = 1 | 100% modulation |
| m > 1 | Over-modulation (distortion) |

### Envelope Detection Math

1. Take magnitude of complex signal:
$$|s(t)| = A_c [1 + m \cdot x(t)]$$

2. Remove DC offset:
$$audio(t) = |s(t)| - A_c = A_c \cdot m \cdot x(t)$$

3. Scale to normalize:
$$output(t) = \frac{audio(t)}{A_c \cdot m} = x(t)$$

---

## 📻 AM Broadcast Bands

### Frequency Allocations

| Band | Region | Frequency Range | Channel Spacing |
|------|--------|-----------------|-----------------|
| LW | Europe | 153 - 279 kHz | 9 kHz |
| MW | ITU-1 | 531 - 1602 kHz | 9 kHz |
| MW | ITU-2 (Americas) | 530 - 1700 kHz | 10 kHz |
| SW | International | 2.3 - 26.1 MHz | Various |

### Common Frequencies

| Frequency | Station Type |
|-----------|--------------|
| 530-1700 kHz | AM broadcast |
| 2.5, 5, 10, 15, 20 MHz | WWV time signals |
| 5.9-6.2 MHz | 49m shortwave |
| 9.4-9.9 MHz | 31m shortwave |
| 11.6-12.1 MHz | 25m shortwave |

---

## 🧪 SDR Settings for AM

### Recommended Settings

| Parameter | Value | Reason |
|-----------|-------|--------|
| **Sample Rate** | 250-500 kSPS | Sufficient for AM |
| **RF Gain** | Medium | Avoid overload |
| **Channel BW** | 10 kHz | Standard AM |
| **Audio BW** | 5 kHz | Speech quality |
| **Direct Sampling** | Required for MW | Below 24 MHz |

### Direct Sampling for MW

```
    RTL-SDR DIRECT SAMPLING FOR AM BROADCAST
    
    Standard Mode (24 MHz - 1.7 GHz):
    
    Antenna → Tuner IC → ADC → USB
              (R820T)
    
    Direct Sampling Mode (0.5 - 24 MHz):
    
    Antenna → [bypass] → ADC → USB
              Tuner      (direct connection)
    
    Use Q-branch (direct_samp=2) for best results
```

---

## 🔊 Audio Processing

### Post-Demodulation Filtering

```
    AUDIO CHAIN
    
    ┌──────────┐     ┌──────────┐     ┌──────────┐
    │ Envelope │────▶│ High-Pass│────▶│ Low-Pass │────▶ Audio
    │ Detector │     │  50 Hz   │     │  5 kHz   │
    └──────────┘     └──────────┘     └──────────┘
                          │                │
                     Remove DC        Remove hiss
```

### Filter Specifications

| Filter | Cutoff | Purpose |
|--------|--------|---------|
| DC Block | 50 Hz HPF | Remove carrier offset |
| Audio LPF | 5 kHz | Remove noise above audio |
| De-emphasis | 75 μs | Match broadcast standard |

---

*AM: Simple but effective modulation since 1906!*
