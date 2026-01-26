# FM Demodulation

> **Frequency Modulation** - Understanding and implementing FM demodulation.

---

## 📖 Contents

| Section | Description |
|---------|-------------|
| [Overview](#-overview) | What is FM |
| [Theory](#-fm-theory) | How FM works |
| [Demodulation](#-demodulation-methods) | Various FM demod techniques |
| [WFM vs NFM](#-wfm-vs-nfm) | Wideband vs Narrowband |
| [GNU Radio](#-gnu-radio-implementation) | Practical flowgraphs |
| [Stereo FM](#-stereo-fm) | MPX and RDS |

---

## 📻 Overview

### What is FM?

Frequency Modulation encodes information by varying the instantaneous frequency of a carrier wave. FM provides better noise immunity than AM.

The following diagram shows FM signal structure:

```
    FREQUENCY MODULATION
    
    MODULATING SIGNAL (Audio)          CARRIER (Unmodulated)
    
         ╱────╲                         ╱╲  ╱╲  ╱╲  ╱╲  ╱╲
       ╱        ╲                      ╱  ╲╱  ╲╱  ╲╱  ╲╱  ╲
      ╱          ╲
    ─╱            ╲─                   Constant frequency
    
                         ↓ Modulation ↓
    
    FM SIGNAL (Modulated Carrier)
    
         High audio = High frequency    Low audio = Low frequency
                │                              │
                ▼                              ▼
    ╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲        ╱╲  ╱╲  ╱╲  ╱╲  ╱╲
    Dense oscillations        Sparse oscillations
    
    The instantaneous FREQUENCY varies with audio amplitude
```

### FM vs AM Comparison

| Aspect | AM | FM |
|--------|-----|-----|
| **Noise immunity** | Poor | Excellent |
| **Bandwidth** | Narrow | Wide |
| **Audio quality** | Limited | High fidelity |
| **Complexity** | Simple | More complex |
| **Capture effect** | No | Yes |

---

## 📊 FM Theory

### Key Parameters

| Parameter | Symbol | Description |
|-----------|--------|-------------|
| **Carrier frequency** | fc | Center frequency |
| **Frequency deviation** | Δf | Max frequency shift |
| **Modulation index** | β | Δf / fm (audio freq) |
| **Bandwidth** | BW | Occupied spectrum |

### Carson's Rule

FM bandwidth approximation:

$$BW \approx 2(\Delta f + f_m)$$

Where:
- Δf = Maximum frequency deviation
- fm = Maximum modulating frequency

### Frequency Spectrum

```
    FM SPECTRUM (BESSEL FUNCTIONS)
    
    Power
    ▲
    │          ┌─┐
    │         ┌┤ ├┐
    │        ┌┤ │ ├┐          Carrier and
    │       ┌┤ │ │ ├┐         multiple sidebands
    │      ┌┤ │ │ │ ├┐
    │     ┌┤ │ │ │ │ ├┐
    │    ┌┤ │ │ │ │ │ ├┐
    └────┴┴─┴─┴─┴─┴─┴─┴┴──────────▶ Frequency
              │
             fc
         
    Unlike AM, FM has theoretically infinite sidebands
    (but most power in first few)
```

---

## 🔧 Demodulation Methods

### 1. Quadrature Demodulator

Most common in SDR:

```
    QUADRATURE DEMODULATOR
    
    ┌───────────────────────────────────────────────────────┐
    │                                                        │
    │  I/Q Input                                             │
    │     │                                                  │
    │     ▼                                                  │
    │  ┌─────────────┐                                       │
    │  │   Delay     │─────────────┐                         │
    │  │   z⁻¹       │             │                         │
    │  └─────────────┘             ▼                         │
    │         │              ┌───────────┐                   │
    │         │              │ Conjugate │                   │
    │         │              │ Multiply  │                   │
    │         │              └─────┬─────┘                   │
    │         │                    │                         │
    │         └────────────────────┤                         │
    │                              ▼                         │
    │                        ┌───────────┐                   │
    │                        │  atan2    │───▶ Audio Out     │
    │                        │ (phase)   │                   │
    │                        └───────────┘                   │
    │                                                        │
    └───────────────────────────────────────────────────────┘
    
    Calculates phase change between samples → frequency
```

### 2. PLL (Phase-Locked Loop)

```
    PLL FM DEMODULATOR
    
    FM Input ──▶ ┌─────────────┐     ┌─────────────┐
                 │   Phase     │────▶│  Loop       │──▶ Audio
                 │  Detector   │     │  Filter     │
                 └──────┬──────┘     └─────────────┘
                        │                   │
                        │                   │
                 ┌──────┴──────┐           │
                 │     VCO     │◀──────────┘
                 │             │
                 └─────────────┘
    
    VCO control voltage = demodulated audio
```

### Method Comparison

| Method | Complexity | SNR | CPU Usage |
|--------|------------|-----|-----------|
| Quadrature | Simple | Good | Low |
| PLL | Complex | Best | Medium |
| Differentiator | Simple | Fair | Low |
| Foster-Seeley | Analog | Good | N/A |

---

## 📶 WFM vs NFM

### Comparison Table

| Parameter | WFM (Broadcast) | NFM (Voice) |
|-----------|-----------------|-------------|
| **Bandwidth** | ~200 kHz | ~12.5-25 kHz |
| **Deviation** | ±75 kHz | ±5 kHz |
| **Audio Range** | 15 kHz | 3 kHz |
| **Use Case** | FM radio | Two-way radio |
| **Quality** | Hi-fi | Voice-grade |

### Spectrum Comparison

```
    WFM (BROADCAST FM)               NFM (NARROWBAND FM)
    
    Power                            Power
    ▲                                ▲
    │ ┌──────────────────────┐       │    ┌────┐
    │ │████████████████████████│       │    │████│
    │ │████████████████████████│       │    │████│
    │ │████████████████████████│       │   ▐██████▌
    └─┴────────────────────────┴──▶   └───┴──────┴────▶
      │◀─────── 200 kHz ─────►│         │◀─12.5kHz─►│
```

---

## 🛠️ GNU Radio Implementation

### WFM Receiver Flowgraph

```
    WFM BROADCAST RECEIVER
    
    ┌────────────┐     ┌────────────┐     ┌────────────┐
    │  RTL-SDR   │────▶│  Low-Pass  │────▶│  WBFM      │
    │  Source    │     │  Filter    │     │  Receive   │
    │ 2 MSPS     │     │  100 kHz   │     │  Demod     │
    │ fc=100.1M  │     └────────────┘     └─────┬──────┘
    └────────────┘                              │
                                                │
         ┌──────────────────────────────────────┘
         │
         ▼
    ┌────────────┐     ┌────────────┐     ┌────────────┐
    │  Resample  │────▶│ De-emphasis│────▶│   Audio    │
    │  → 48 kHz  │     │   75 μs    │     │   Sink     │
    └────────────┘     └────────────┘     └────────────┘
```

### NFM Receiver Flowgraph

```
    NFM VOICE RECEIVER
    
    ┌────────────┐     ┌────────────┐     ┌────────────┐
    │  RTL-SDR   │────▶│  Low-Pass  │────▶│   NBFM     │
    │  Source    │     │  Filter    │     │  Receive   │
    │ 250 kSPS   │     │  12.5 kHz  │     │  Demod     │
    │ fc=146.52M │     └────────────┘     └─────┬──────┘
    └────────────┘                              │
                                                │
         ┌──────────────────────────────────────┘
         │
         ▼
    ┌────────────┐     ┌────────────┐     ┌────────────┐
    │  Resample  │────▶│  Squelch   │────▶│   Audio    │
    │  → 48 kHz  │     │  -30 dB    │     │   Sink     │
    └────────────┘     └────────────┘     └────────────┘
```

### Key Blocks

| Block | WFM | NFM |
|-------|-----|-----|
| Sample Rate | 2+ MSPS | 250+ kSPS |
| Channel Filter | 100-200 kHz | 12.5-25 kHz |
| Demod Block | WBFM Receive | NBFM Receive |
| Audio Rate | 48 kHz | 8-48 kHz |
| De-emphasis | 75 μs | None/50 μs |
| Squelch | Optional | Recommended |

---

## 🎵 Stereo FM

### MPX (Multiplex) Structure

Broadcast FM includes stereo and RDS:

```
    FM STEREO MULTIPLEX (MPX)
    
    Frequency
    ▲
    │
    │  ┌───────┐           ┌───────┐           ┌───────┐
    │  │ L+R   │           │  L-R  │           │  RDS  │
    │  │ Mono  │    19kHz  │Stereo │   57kHz   │ Data  │
    │  │       │    Pilot  │(DSB-SC)│          │       │
    │  │       │     ↓     │       │           │       │
    └──┴───────┴─────┼─────┴───────┴───────────┴───────┴───▶
    0            19      38              53   57      kHz
    │◀── 15 kHz ─►│         │◀── 30 kHz ─►│
```

### Stereo Decoding Process

```
    STEREO DECODING
    
    MPX Input
        │
        ├───────────────────────────────┐
        │                               │
        ▼                               ▼
    ┌────────────┐               ┌────────────┐
    │  LPF 15kHz │               │  BPF 19kHz │───┐
    │   (L+R)    │               │   (Pilot)  │   │
    └─────┬──────┘               └────────────┘   │
          │                                       ▼
          │                              ┌────────────┐
          │                              │    PLL     │
          │                              │   × 2      │
          │                              │ (→ 38 kHz) │
          │                              └──────┬─────┘
          │                                     │
          │         ┌────────────┐              │
          │         │  BPF       │◀─────────────┘
          │         │  23-53 kHz │
          │         │   (L-R)    │
          │         └─────┬──────┘
          │               │
          │               ▼
          │         ┌────────────┐
          │         │  Multiply  │
          │         │  × 38 kHz  │
          │         └─────┬──────┘
          │               │
          ▼               ▼
    ┌────────────┐  ┌────────────┐
    │    L+R     │  │    L-R     │
    └─────┬──────┘  └─────┬──────┘
          │               │
          └───────┬───────┘
                  │
          ┌───────┴───────┐
          ▼               ▼
    ┌────────────┐  ┌────────────┐
    │  L = (L+R) │  │  R = (L+R) │
    │    + (L-R) │  │    - (L-R) │
    └────────────┘  └────────────┘
```

### RDS (Radio Data System)

| Feature | Description |
|---------|-------------|
| PI | Program Identification code |
| PS | Program Service (station name) |
| RT | Radio Text (scrolling text) |
| PTY | Program Type (genre) |
| TA/TP | Traffic announcements |

---

## 📐 Mathematical Background

### FM Signal Equation

$$s(t) = A_c \cos\left(2\pi f_c t + 2\pi k_f \int_0^t m(\tau) d\tau\right)$$

Where:
- $A_c$ = Carrier amplitude
- $f_c$ = Carrier frequency
- $k_f$ = Frequency sensitivity (Hz/V)
- $m(t)$ = Modulating signal

### Instantaneous Frequency

$$f_i(t) = f_c + k_f \cdot m(t)$$

### Quadrature Demodulation Math

For complex baseband signal:
$$z(t) = I(t) + jQ(t)$$

Phase:
$$\phi(t) = \arctan\left(\frac{Q(t)}{I(t)}\right)$$

Demodulated output:
$$audio(t) = \frac{d\phi}{dt} = \frac{I \cdot \frac{dQ}{dt} - Q \cdot \frac{dI}{dt}}{I^2 + Q^2}$$

---

## 🎚️ De-emphasis

### Pre-emphasis/De-emphasis

High frequencies are boosted at transmitter (pre-emphasis) and reduced at receiver (de-emphasis):

```
    PRE-EMPHASIS / DE-EMPHASIS
    
    Gain (dB)
    ▲
    │  Pre-emphasis (TX)              De-emphasis (RX)
    │    ╱                               ╲
    │   ╱                                 ╲
    │  ╱                                   ╲
    │ ╱                                     ╲
    └─────────────────────▶ Freq     └────────────────────▶ Freq
    
    Net result: Flat response with reduced noise
```

### Time Constants

| Region | Time Constant |
|--------|---------------|
| USA, Korea | 75 μs |
| Europe, Australia | 50 μs |

---

## 🔧 Command Line Tools

### rtl_fm for FM Reception

```bash
# WFM broadcast
rtl_fm -M wbfm -f 100.3M -s 200000 -r 48000 - | aplay -r 48000 -f S16_LE

# NFM voice
rtl_fm -M fm -f 146.52M -s 24000 -r 24000 - | aplay -r 24000 -f S16_LE

# NFM with squelch
rtl_fm -M fm -f 462.5625M -s 24000 -l 30 - | aplay -r 24000 -f S16_LE
```

### Parameters

| Parameter | Description |
|-----------|-------------|
| -M wbfm | Wideband FM mode |
| -M fm | Narrowband FM mode |
| -f | Center frequency |
| -s | Sample rate |
| -r | Output audio rate |
| -l | Squelch level |

---

*FM: Crystal-clear audio since 1933!*
