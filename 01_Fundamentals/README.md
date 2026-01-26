# 01_Fundamentals

> **Core concepts for understanding Software Defined Radio.**

---

## 📖 Contents

| Document | Description |
|----------|-------------|
| [What_Is_SDR.md](What_Is_SDR.md) | Introduction to Software Defined Radio |
| [RF_Basics.md](RF_Basics.md) | Radio frequency fundamentals |
| [Sampling_Theory.md](Sampling_Theory.md) | Nyquist, aliasing, sample rates |
| [Quadrature_Signals.md](Quadrature_Signals.md) | I/Q data explained |
| [Decibels_Power.md](Decibels_Power.md) | dB, dBm, power calculations |
| [Antenna_Basics.md](Antenna_Basics.md) | Antenna fundamentals |

---

## 🎯 Learning Path

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   What is SDR   │────▶│    RF Basics    │────▶│ Sampling Theory │
└─────────────────┘     └─────────────────┘     └─────────────────┘
                                                         │
         ┌───────────────────────────────────────────────┘
         ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  I/Q Signals    │────▶│    Decibels     │────▶│    Antennas     │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

---

## 🔑 Key Concepts

The following table summarizes the key concepts covered in this section:

| Concept | Why It Matters |
|---------|----------------|
| **SDR Architecture** | Understanding the hardware/software split |
| **RF Propagation** | How radio waves travel |
| **Nyquist Theorem** | Minimum sampling rate requirement |
| **I/Q Representation** | How SDRs capture full signal information |
| **Decibels** | Universal RF measurement unit |
| **Antenna Basics** | Matching antenna to frequency |

---

## 📐 Essential Formulas

The following formulas are fundamental to SDR work:

| Formula | Description |
|---------|-------------|
| $f_{Nyquist} = 2 \times f_{max}$ | Minimum sample rate |
| $\lambda = \frac{c}{f}$ | Wavelength from frequency |
| $P_{dBm} = 10 \log_{10}(P_{mW})$ | Power in dBm |
| $dB = 10 \log_{10}(\frac{P_1}{P_2})$ | Power ratio in dB |
| $V_{dB} = 20 \log_{10}(\frac{V_1}{V_2})$ | Voltage ratio in dB |

---

*See also: [GLOSSARY.md](../GLOSSARY.md) for terminology*
