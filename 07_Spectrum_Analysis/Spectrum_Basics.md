# Spectrum Analysis Basics

> Understanding the frequency domain — how to read, interpret, and work with RF spectrum displays.

---

## 1. What Is Spectrum Analysis?

Spectrum analysis transforms a time-domain signal into its **frequency-domain**
representation, revealing the power distribution across frequencies. It is the
primary tool for identifying, measuring, and understanding RF signals.

```
Time Domain                     Frequency Domain
                                     Power
 Amplitude                            ▲
    ▲                                  │  ┌─┐
    │  ╱╲  ╱╲  ╱╲                     │  │ │
    │ ╱  ╲╱  ╲╱  ╲                    │  │ │ ┌─┐
    │╱    +harmonics                   │  │ │ │ │
    └──────────────► t         ───────┴──┴─┴─┴─┴──► f
                                      f₁    f₂
```

## 2. Key Concepts

### Power Spectral Density (PSD)

$$
S_{xx}(f) = \lim_{T \to \infty} \frac{1}{T} \left| \int_{-T/2}^{T/2} x(t)\, e^{-j2\pi ft}\, dt \right|^2
$$

In practice, we compute PSD using the **FFT** of windowed segments (Welch's method).

### Decibel Scale

| Measurement | Formula              | Reference        |
|-------------|----------------------|------------------|
| dBm         | $10\log_{10}(P/1mW)$ | 1 milliwatt      |
| dBW         | $10\log_{10}(P/1W)$  | 1 watt           |
| dBFS        | $20\log_{10}(A/A_{FS})$ | Full scale    |
| dBμV        | $20\log_{10}(V/1μV)$ | 1 microvolt      |

### Key dBm Reference Points

| Power       | dBm    | Typical Source              |
|-------------|--------|-----------------------------|
| 1 μW        | −30    | Weak received signal        |
| 1 mW        | 0      | Reference                   |
| 100 mW      | +20    | Handheld radio              |
| 1 W         | +30    | Mobile phone max            |
| 50 W        | +47    | FM broadcast                |

## 3. FFT Parameters

| Parameter     | Effect                          | Trade-off              |
|---------------|---------------------------------|------------------------|
| FFT size (N)  | Frequency resolution = Fs/N     | More points = slower   |
| Window        | Sidelobe suppression            | Main lobe widens       |
| Overlap       | Smoother display                | More computation       |
| Averaging     | Reduces noise variance          | Slower response        |

### Resolution Bandwidth (RBW)

$$
RBW = \frac{F_s}{N}
$$

Example: Fs = 2.4 MHz, N = 4096 → RBW = 585 Hz

## 4. Reading a Spectrum Display

```
 Power (dBFS)
    0 ┤
  -20 ┤          ┌──┐
  -40 ┤    ┌─┐   │  │  ┌─┐
  -60 ┤ ───┤S├───┤FM├──┤S├───  ← Noise floor
  -80 ┤    └─┘   │  │  └─┘
 -100 ┤          └──┘
      └──────────────────────► Frequency
           ↑       ↑      ↑
        Spur    Signal   Spur

 S = spurious signal / interference
```

### What to Look For

- **Signal peaks** — centre frequency, bandwidth, power level
- **Noise floor** — determines receiver sensitivity
- **Spurious signals** — unwanted artifacts from LO leakage, harmonics, IMD
- **Bandwidth** — occupied bandwidth at −3 dB, −20 dB, or −60 dB points
- **Modulation** — shape of the signal reveals modulation type

## 5. Window Functions

| Window      | Main Lobe | Sidelobe | Best For                 |
|-------------|-----------|----------|--------------------------|
| Rectangular | Narrowest | −13 dB   | Transient analysis       |
| Hann        | Medium    | −31 dB   | General purpose          |
| Hamming     | Medium    | −42 dB   | Narrowband signals       |
| Blackman    | Wide      | −58 dB   | High dynamic range       |
| Flat-top    | Very wide | −44 dB   | Amplitude accuracy       |

## 6. SDR Software Settings

| Software   | FFT Setting          | Where                        |
|------------|---------------------|------------------------------|
| SDR++      | FFT Size dropdown   | Settings → Display           |
| GQRX       | FFT size            | FFT Settings panel           |
| GNU Radio  | QT GUI Sink block   | FFT Size parameter           |
| SDR#       | FFT Resolution      | FFT Display section          |

### Recommended Starting Points

```
FFT Size:   4096 (good balance)
Window:     Blackman-Harris
Averaging:  5–10 frames
Overlap:    50%
```

---

**See also**: [FFT & Spectrum Analysis](../04_DSP_Fundamentals/FFT_Spectrum.md) | [Waterfall Display](Waterfall_Display.md) | [Decibels & Power](../01_Fundamentals/Decibels_Power.md)
