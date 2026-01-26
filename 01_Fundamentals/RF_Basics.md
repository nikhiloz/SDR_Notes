# RF Basics

> **Radio Frequency Fundamentals** - Essential RF concepts for SDR work.

---

## 1. Electromagnetic Spectrum

### 1.1 Overview

Radio waves are electromagnetic radiation with wavelengths longer than infrared light. SDRs typically work in the RF portion of the spectrum.

The following diagram shows where RF fits in the electromagnetic spectrum:

```
                    ELECTROMAGNETIC SPECTRUM
                    
   ◀──────────────────── Increasing Frequency ────────────────────▶
   ◀──────────────────── Decreasing Wavelength ───────────────────▶
   
┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
│ Radio  │Micro-  │Infrared│Visible │  UV    │ X-Ray  │ Gamma  │        │
│ Waves  │wave    │        │ Light  │        │        │  Ray   │        │
├────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┤
│ 3 kHz          3 GHz    300 GHz   430 THz  750 THz   30 PHz   >30 EHz │
└───────────────────────────────────────────────────────────────────────┘
        │
        └──── SDR Range (typically kHz to a few GHz)
```

### 1.2 Radio Frequency Bands

The following table shows the standard RF band designations:

| Band | Frequency | Wavelength | Typical Uses |
|------|-----------|------------|--------------|
| **VLF** | 3-30 kHz | 100-10 km | Submarine comms, time signals |
| **LF** | 30-300 kHz | 10-1 km | Navigation (LORAN), AM longwave |
| **MF** | 300 kHz - 3 MHz | 1000-100 m | AM broadcast, maritime |
| **HF** | 3-30 MHz | 100-10 m | Shortwave, amateur, aviation HF |
| **VHF** | 30-300 MHz | 10-1 m | FM broadcast, TV, aircraft, marine |
| **UHF** | 300 MHz - 3 GHz | 100-10 cm | TV, cellular, WiFi, GPS |
| **SHF** | 3-30 GHz | 10-1 cm | Satellite, radar, 5G |
| **EHF** | 30-300 GHz | 10-1 mm | 5G mmWave, imaging |

---

## 2. Wavelength and Frequency

### 2.1 The Fundamental Relationship

Frequency and wavelength are inversely related:

$$\lambda = \frac{c}{f}$$

Where:
- $\lambda$ = wavelength (meters)
- $c$ = speed of light (≈ 3 × 10⁸ m/s)
- $f$ = frequency (Hz)

### 2.2 Quick Reference Table

The following table provides wavelength for common frequencies:

| Frequency | Wavelength | Common Name |
|-----------|------------|-------------|
| 1 MHz | 300 m | AM broadcast |
| 100 MHz | 3 m | FM broadcast |
| 433 MHz | 69 cm | ISM band |
| 915 MHz | 33 cm | ISM (US) |
| 1090 MHz | 27.5 cm | ADS-B |
| 2.4 GHz | 12.5 cm | WiFi, Bluetooth |
| 5.8 GHz | 5.2 cm | WiFi 5 GHz |

### 2.3 Why Wavelength Matters

The following diagram shows how wavelength affects antenna size:

```
    WAVELENGTH AND ANTENNA SIZE
    
    Lower Frequency = Longer Wavelength = Larger Antenna
    
    1 MHz (300m wavelength)
    ════════════════════════════════════════════════════▶  ~75m antenna (λ/4)
    
    100 MHz (3m wavelength)
    ════════▶  ~75cm antenna (λ/4)
    
    1 GHz (30cm wavelength)
    ══▶  ~7.5cm antenna (λ/4)
    
    Quarter-wave (λ/4) is common efficient antenna length
```

---

## 3. Signal Characteristics

### 3.1 Key Signal Parameters

The following table describes the fundamental properties of RF signals:

| Parameter | Symbol | Unit | Description |
|-----------|--------|------|-------------|
| **Frequency** | f | Hz | Cycles per second |
| **Wavelength** | λ | m | Physical length of one cycle |
| **Amplitude** | A | V, dBm | Signal strength |
| **Phase** | φ | degrees, radians | Position in cycle |
| **Bandwidth** | BW | Hz | Frequency range occupied |

### 3.2 Time Domain vs Frequency Domain

The following diagram shows the two ways to view a signal:

```
    TIME DOMAIN                      FREQUENCY DOMAIN
    (Oscilloscope view)              (Spectrum analyzer view)
    
    Amplitude                        Power
        │    ╱╲    ╱╲                   │
        │   ╱  ╲  ╱  ╲                  │    ▐█▌
        │  ╱    ╲╱    ╲                 │    ▐█▌
        │ ╱            ╲                │    ▐█▌
        ├────────────────▶ Time         ├────────────▶ Frequency
        │                               │
        
    Shows: How signal changes          Shows: What frequencies
           over time                          are present
           
    FFT (Fast Fourier Transform) converts between domains
```

---

## 4. Propagation

### 4.1 How Radio Waves Travel

RF propagation depends on frequency. The following table summarizes propagation modes:

| Mode | Frequency Range | Description |
|------|-----------------|-------------|
| **Ground Wave** | LF, MF | Follows Earth's surface |
| **Sky Wave** | HF | Reflects off ionosphere |
| **Line of Sight** | VHF and above | Direct path, limited by horizon |
| **Tropospheric** | VHF, UHF | Weather layer ducting |
| **Satellite** | UHF, SHF | Via orbiting repeaters |

### 4.2 Line of Sight Distance

For VHF and above, maximum range is approximately:

$$d_{km} \approx 4.12 \times (\sqrt{h_1} + \sqrt{h_2})$$

Where $h_1$ and $h_2$ are antenna heights in meters.

The following table shows example line-of-sight ranges:

| Antenna Height | Range to Horizon |
|----------------|------------------|
| 1.5 m (handheld) | ~5 km |
| 10 m (roof) | ~13 km |
| 100 m (tower) | ~41 km |
| 10 km (aircraft) | ~130 km |

---

## 5. Modulation Basics

### 5.1 Why Modulate?

Raw audio/data frequencies are too low to radiate efficiently. Modulation moves information to higher (RF) frequencies.

The following diagram shows the modulation concept:

```
    MODULATION CONCEPT
    
    Information Signal              Carrier Signal              Modulated Signal
    (Baseband)                      (RF)                        (Transmitted)
    
         ╱╲                        ╱╲╱╲╱╲╱╲╱╲╱╲              ╱╲╱╲  ╱╲╱╲
        ╱  ╲                      ╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲           ╱╲╱╲╱╲╱╲╱╲
       ╱    ╲        +                                   =   ╱╲╱╲    ╱╲╱╲
      ╱      ╲                                               ╱╲╱╲╱╲╱╲╱╲╱╲
                                                           (envelope varies
    Low frequency                 High frequency             with information)
    (e.g., audio)                 (e.g., 100 MHz)
```

### 5.2 Modulation Types Overview

The following table compares basic modulation types:

| Type | Varies | Analog | Digital |
|------|--------|--------|---------|
| **Amplitude** | Signal strength | AM | ASK, OOK |
| **Frequency** | Carrier frequency | FM | FSK |
| **Phase** | Carrier phase | PM | PSK, QPSK |
| **Combined** | Amplitude + Phase | - | QAM |

---

## 6. Power and Decibels

### 6.1 Why Use Decibels?

RF signals span enormous ranges (microvolts to kilowatts). Decibels make this manageable:

| Linear Ratio | Decibels |
|--------------|----------|
| 1 | 0 dB |
| 2 | 3 dB |
| 10 | 10 dB |
| 100 | 20 dB |
| 1000 | 30 dB |
| 1,000,000 | 60 dB |

### 6.2 Decibel Formulas

For power:
$$dB = 10 \log_{10}\left(\frac{P_1}{P_2}\right)$$

For voltage (into same impedance):
$$dB = 20 \log_{10}\left(\frac{V_1}{V_2}\right)$$

### 6.3 Absolute Power: dBm

dBm is power relative to 1 milliwatt:

$$P_{dBm} = 10 \log_{10}(P_{mW})$$

The following table shows common power levels in dBm:

| Power | dBm | Example |
|-------|-----|---------|
| 1 μW | -30 dBm | Weak received signal |
| 1 mW | 0 dBm | Reference |
| 10 mW | +10 dBm | Low power transmit |
| 100 mW | +20 dBm | WiFi typical |
| 1 W | +30 dBm | Amateur radio |
| 100 W | +50 dBm | Commercial broadcast |

---

## 7. Noise

### 7.1 Sources of Noise

The following table lists common noise sources:

| Source | Description |
|--------|-------------|
| **Thermal** | Random electron motion in conductors |
| **Atmospheric** | Lightning, space noise |
| **Man-made** | Switching supplies, motors, computers |
| **Quantization** | ADC bit resolution limit |
| **Phase noise** | Oscillator instability |

### 7.2 Signal-to-Noise Ratio (SNR)

$$SNR_{dB} = 10 \log_{10}\left(\frac{P_{signal}}{P_{noise}}\right)$$

The following table shows typical SNR requirements:

| Application | Minimum SNR |
|-------------|-------------|
| Voice (AM) | 10 dB |
| Voice (FM) | 12 dB |
| Digital (BPSK) | 6-10 dB |
| Digital (64-QAM) | 25+ dB |

### 7.3 Noise Figure

Noise Figure (NF) measures how much noise an amplifier adds:

$$NF_{dB} = SNR_{in,dB} - SNR_{out,dB}$$

A lower NF is better. LNAs typically have NF of 0.5-3 dB.

---

## 8. RF System Concepts

### 8.1 Receiver Sensitivity

Minimum detectable signal depends on:
- Bandwidth
- Noise figure
- Required SNR

$$P_{min} = -174 + 10\log_{10}(BW) + NF + SNR_{required}$$ (dBm)

### 8.2 Dynamic Range

The following diagram shows receiver dynamic range:

```
    RECEIVER DYNAMIC RANGE
    
    ┌─────────────────────────────────────────────────────┐
    │                                                     │
    │  ▲ Signal Level                                     │
    │  │                                                  │
    │  │  ████████████  Saturation/Clipping               │
    │  │  ────────────  Maximum Input ◄─────────────┐     │
    │  │                                            │     │
    │  │       ▲                                    │     │
    │  │       │  Dynamic Range                     │     │
    │  │       │  (Usable signals)                  │     │
    │  │       ▼                                          │
    │  │                                            │     │
    │  │  ────────────  Noise Floor ◄───────────────┘     │
    │  │  ░░░░░░░░░░░░  Thermal Noise                     │
    │  │                                                  │
    │  └──────────────────────────────────────────────▶   │
    │                    Frequency                        │
    │                                                     │
    └─────────────────────────────────────────────────────┘
    
    Wider dynamic range = can handle weak AND strong signals
```

---

## 9. Impedance Matching

### 9.1 Standard Impedances

The following table shows common RF impedances:

| Impedance | Application |
|-----------|-------------|
| **50 Ω** | Most RF equipment, test equipment |
| **75 Ω** | Cable TV, video, broadcast |
| **300 Ω** | Older TV antennas (twin-lead) |

### 9.2 Why Matching Matters

Mismatched impedances cause:
- Signal reflections
- Power loss
- Standing waves (VSWR > 1.0)

Perfect match: VSWR = 1.0:1 (all power transferred)
Acceptable: VSWR < 2.0:1

---

## 10. Summary

The following table summarizes key RF concepts:

| Concept | Key Point |
|---------|-----------|
| **Wavelength** | λ = c/f, determines antenna size |
| **Propagation** | Depends on frequency (sky wave, LOS, etc.) |
| **Modulation** | Moves info to RF for transmission |
| **Decibels** | Logarithmic scale for RF power |
| **dBm** | Absolute power (0 dBm = 1 mW) |
| **SNR** | Signal quality measure |
| **Impedance** | Usually 50Ω, must match for efficiency |

---

*Next: [Sampling_Theory.md](Sampling_Theory.md) - Nyquist theorem and digital sampling*
