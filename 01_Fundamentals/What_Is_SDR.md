# What Is Software Defined Radio (SDR)?

> **Software Defined Radio** - A radio communication system where components traditionally implemented in hardware are instead implemented through software.

---

## 1. Overview

### 1.1 Definition

A **Software Defined Radio (SDR)** is a radio system where the signal processing that was traditionally done by hardware (filters, mixers, amplifiers, modulators, demodulators) is instead performed by software running on a general-purpose processor or FPGA.

The following diagram contrasts traditional hardware radio with software defined radio:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    TRADITIONAL HARDWARE RADIO                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────┐   ┌─────┐   ┌─────────┐   ┌──────────┐   ┌─────────────────┐   │
│  │ Antenna │──▶│ LNA │──▶│ Filters │──▶│ Hardware │──▶│ Fixed Function  │   │
│  └─────────┘   └─────┘   │(fixed)  │   │Demod     │   │ Output          │   │
│                          └─────────┘   └──────────┘   └─────────────────┘   │
│                                                                              │
│  ⚠️  Single purpose, fixed frequency, hardware changes required             │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                    SOFTWARE DEFINED RADIO (SDR)                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────┐   ┌─────┐   ┌─────┐   ┌─────┐   ┌──────────────────────────┐   │
│  │ Antenna │──▶│ LNA │──▶│Mixer│──▶│ ADC │──▶│     SOFTWARE             │   │
│  └─────────┘   └─────┘   └──┬──┘   └─────┘   │  ┌────────────────────┐  │   │
│                             │                │  │ Filtering          │  │   │
│                        ┌────┴────┐           │  │ Demodulation       │  │   │
│                        │   LO    │           │  │ Decoding           │  │   │
│                        │(Tuner)  │           │  │ Analysis           │  │   │
│                        └─────────┘           │  │ Recording          │  │   │
│                                              │  └────────────────────┘  │   │
│                                              └──────────────────────────┘   │
│  ✅  Multi-purpose, flexible, software changes only                         │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 1.2 Key Advantages

The following table compares SDR advantages versus traditional radios:

| Advantage | Description |
|-----------|-------------|
| **Flexibility** | Change frequency, modulation, protocol via software |
| **Multi-mode** | One device handles AM, FM, SSB, digital modes |
| **Upgradability** | New features via software updates |
| **Cost** | Single hardware covers many applications |
| **Education** | See inside the radio - visualize signals |
| **Experimentation** | Try new protocols without hardware changes |
| **Wideband** | Capture large spectrum chunks for analysis |

### 1.3 Key Disadvantages

The following table lists SDR limitations:

| Limitation | Description |
|------------|-------------|
| **Latency** | Software processing adds delay |
| **Power consumption** | Computer required = more power |
| **RF performance** | Dedicated hardware often has better specs |
| **Complexity** | Steeper learning curve |
| **CPU load** | Heavy DSP can tax processor |

---

## 2. SDR Architecture

### 2.1 Block Diagram

The following diagram shows the complete SDR receive chain:

```
                           SDR RECEIVER ARCHITECTURE
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  ANALOG (RF)                           DIGITAL                                │
│  ──────────────────────────────────────────────────────────────────────────  │
│                                                                               │
│  ┌─────────┐  ┌─────┐  ┌─────────────┐  ┌─────┐  ┌────────────────────────┐  │
│  │         │  │     │  │    Mixer    │  │     │  │                        │  │
│  │ Antenna │─▶│ LNA │─▶│  (Tuner)    │─▶│ ADC │─▶│    DIGITAL SIGNAL     │  │
│  │         │  │     │  │             │  │     │  │    PROCESSING (DSP)    │  │
│  └─────────┘  └─────┘  └──────┬──────┘  └─────┘  │                        │  │
│                               │                   │  ┌──────────────────┐ │  │
│                         ┌─────┴─────┐             │  │ DDC (Tuning)     │ │  │
│                         │    LO     │◄── Tune     │  │ Filtering        │ │  │
│                         │ (NCO/PLL) │    Control  │  │ Decimation       │ │  │
│                         └───────────┘             │  │ Demodulation     │ │  │
│                                                   │  │ Decoding         │ │  │
│                                                   │  └──────────────────┘ │  │
│                                                   │                        │  │
│                                                   └────────────────────────┘  │
│                                                              │                │
│                                                              ▼                │
│                                                   ┌────────────────────────┐  │
│                                                   │    APPLICATION         │  │
│                                                   │  - Spectrum Display    │  │
│                                                   │  - Audio Output        │  │
│                                                   │  - Data Decode         │  │
│                                                   │  - Recording           │  │
│                                                   └────────────────────────┘  │
│                                                                               │
└──────────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Component Functions

The following table describes each component in the SDR receive chain:

| Component | Function | Hardware/Software |
|-----------|----------|-------------------|
| **Antenna** | Converts EM waves to electrical signal | Hardware |
| **LNA** | Low Noise Amplifier - boosts weak signals | Hardware |
| **Mixer** | Shifts RF to lower frequency (IF or baseband) | Hardware |
| **LO** | Local Oscillator - provides tuning reference | Hardware |
| **ADC** | Converts analog to digital samples | Hardware |
| **DDC** | Digital Down Converter - fine tuning | Software/FPGA |
| **Filters** | Remove unwanted frequencies | Software |
| **Demodulator** | Extract information from signal | Software |
| **Decoder** | Interpret protocol/data | Software |

---

## 3. SDR Architectures

### 3.1 Superheterodyne vs Direct Conversion

The following table compares common SDR receiver architectures:

| Architecture | Description | Pros | Cons |
|--------------|-------------|------|------|
| **Superheterodyne** | RF → IF → Baseband | Good selectivity, proven | Complex, image issues |
| **Direct Conversion** | RF → Baseband directly | Simple, wideband | DC offset, I/Q imbalance |
| **Low-IF** | RF → Low IF → Baseband | Compromise approach | Some image, less DC offset |
| **Direct Sampling** | RF → ADC (no mixer) | Simplest, no LO | Requires fast ADC, limited BW |

### 3.2 Direct Conversion (Zero-IF)

Most low-cost SDRs (RTL-SDR, HackRF) use direct conversion:

```
                    DIRECT CONVERSION (ZERO-IF)
┌────────────────────────────────────────────────────────────────┐
│                                                                 │
│   RF Input         ┌─────────┐                                  │
│   ─────────────────┤         ├─────────▶ I (In-phase)          │
│                    │ Mixer I │                                  │
│          ┌────────▶│         │         ┌──────┐                │
│          │         └─────────┘         │      │                │
│          │              │              │ ADC  │──▶ I samples   │
│      ┌───┴───┐          │              │      │                │
│      │       │          │              └──────┘                │
│      │ Split │     ┌────┴────┐                                  │
│      │       │     │   LO    │                                  │
│      └───┬───┘     │  0°/90° │                                  │
│          │         └────┬────┘                                  │
│          │              │              ┌──────┐                │
│          │         ┌────┴────┐         │      │                │
│          │         │ Mixer Q │         │ ADC  │──▶ Q samples   │
│          └────────▶│         │         │      │                │
│                    └─────────┘         └──────┘                │
│                         │                                       │
│   ─────────────────────────────────▶ Q (Quadrature)            │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

---

## 4. I/Q Signals

### 4.1 Why I/Q?

The following table explains why SDRs use I/Q (complex) signals:

| Reason | Explanation |
|--------|-------------|
| **Distinguish +/- frequencies** | Real samples can't tell above/below LO |
| **Full signal information** | Captures amplitude AND phase |
| **Efficient processing** | Complex math is natural for DSP |
| **No image problem** | Proper I/Q eliminates image frequency |

### 4.2 I/Q Representation

A signal can be represented as a complex number rotating in the I/Q plane:

```
                    I/Q PLANE (COMPLEX SIGNAL)
                    
              Q (Quadrature, 90°)
              │
              │      ╱  Signal Vector
              │    ╱    (rotating)
              │  ╱
              │╱ θ = phase
   ───────────┼───────────▶ I (In-phase, 0°)
              │
              │
              │
              │
              
    Complex Signal: s(t) = I(t) + j·Q(t)
    
    Amplitude:  A = √(I² + Q²)
    Phase:      θ = atan2(Q, I)
    Frequency:  f = dθ/dt / 2π
```

---

## 5. Sample Rate and Bandwidth

### 5.1 Nyquist Theorem

The **Nyquist-Shannon sampling theorem** states:

> To accurately capture a signal, you must sample at **at least twice** the highest frequency component.

$$f_{sample} \geq 2 \times f_{max}$$

### 5.2 SDR Bandwidth

The following table relates sample rate to usable bandwidth:

| Sample Rate | Usable Bandwidth | Example SDR |
|-------------|------------------|-------------|
| 2.4 MSPS | ~2 MHz | RTL-SDR |
| 10 MSPS | ~8 MHz | SDRPlay RSP1A |
| 20 MSPS | ~18 MHz | HackRF One |
| 56 MSPS | ~50 MHz | USRP B200 |

> **Note:** Usable bandwidth is typically 80-90% of sample rate due to filter roll-off.

---

## 6. SDR Use Cases

The following table shows common SDR applications:

| Category | Applications |
|----------|--------------|
| **Receiving** | AM/FM radio, shortwave, amateur radio |
| **Aviation** | ADS-B tracking, ACARS, VHF airband |
| **Maritime** | AIS vessel tracking |
| **Weather** | NOAA satellite images, weather radio |
| **Trunking** | P25, DMR, TETRA monitoring |
| **ISM Band** | 433 MHz sensors, LoRa, Zigbee |
| **Analysis** | Spectrum monitoring, interference hunting |
| **Security** | RF reverse engineering, penetration testing |
| **Amateur** | Ham radio, digital modes (FT8, etc.) |
| **Education** | Learning RF, DSP, communications |

---

## 7. Getting Started

### 7.1 Recommended First Steps

1. **Get an RTL-SDR** (~$30) - Best value entry point
2. **Install SDR#** (Windows) or **GQRX** (Linux) 
3. **Connect a simple antenna** - Included dipole works for VHF/UHF
4. **Tune to FM broadcast** (88-108 MHz) - Easy first test
5. **Explore the spectrum** - See what signals are around you

### 7.2 Learning Resources

| Resource | Description | Link |
|----------|-------------|------|
| RTL-SDR Blog | News, tutorials, projects | rtl-sdr.com |
| PySDR | Free online textbook | pysdr.org |
| Signal ID Wiki | Signal identification | sigidwiki.com |
| GNU Radio Wiki | DSP framework docs | wiki.gnuradio.org |

---

## 8. Summary

The following table summarizes key SDR concepts:

| Concept | Key Point |
|---------|-----------|
| **SDR** | Radio where signal processing is done in software |
| **Flexibility** | One device, many applications |
| **I/Q** | Complex samples capture full signal information |
| **ADC** | The critical hardware component |
| **Bandwidth** | Limited by sample rate (Nyquist) |
| **Trade-off** | Flexibility vs. dedicated hardware performance |

---

*Next: [RF_Basics.md](RF_Basics.md) - Understanding radio frequency fundamentals*
