# Waterfall Display

> Using waterfall / spectrogram views to visualise signal activity over time.

---

## 1. What Is a Waterfall Display?

A **waterfall** (or spectrogram) shows frequency on the horizontal axis, time on
the vertical axis, and power as colour intensity. It reveals how signals change
over time — essential for identifying intermittent, hopping, or burst signals.

```
Frequency ──────────────────────►
    │ ░░░░████░░░░░░████████░░░░  ← now
    │ ░░░░████░░░░░░████████░░░░
  T │ ░░░░████░░░░░░░░░░░░░░░░░░  ← signal stopped
  i │ ░░░░████░░░░░░░░░░░░░░░░░░
  m │ ░░░░░░░░░░░░░░░░░░░░░░░░░░  ← quiet
  e │ ░░░░░░░░░░████████░░░░░░░░  ← burst started
    │ ░░░░░░░░░░████████░░░░░░░░
    ▼

  ░ = noise floor (blue/black)
  █ = signal present (yellow/red)
```

## 2. Reading a Waterfall

### Signal Types by Appearance

| Pattern               | Description                      | Example           |
|-----------------------|----------------------------------|--------------------|
| Thin vertical line    | CW / narrowband continuous       | Radio beacon       |
| Wide vertical band    | Broadband continuous             | FM broadcast       |
| Horizontal dashes     | Short bursts over time           | Pager / POCSAG     |
| Diagonal line         | Frequency drift or chirp         | LoRa, satellite    |
| Regular grid pattern  | TDMA / time-slotted              | DMR, GSM           |
| Drifting line         | Unstable oscillator / Doppler    | Satellite pass     |
| Spread pattern        | Spread spectrum / noise          | WiFi, Bluetooth    |

### Colour Maps

| Colour scheme | Best for                        |
|---------------|---------------------------------|
| Blue-Red (hot)| General use, high contrast      |
| Greyscale     | Publication, printing           |
| Viridis       | Perceptually uniform analysis   |
| Custom gradient| Highlighting specific power range|

## 3. Waterfall Settings

| Parameter         | Effect                          | Recommended        |
|-------------------|---------------------------------|--------------------|
| **FFT size**      | Frequency resolution            | 4096–8192          |
| **FFT rate**      | Time resolution (lines/sec)     | 15–30 fps          |
| **Colour range**  | Min/max power displayed         | Noise floor ± 60dB |
| **Scroll speed**  | How fast waterfall scrolls      | Match FFT rate     |
| **Averaging**     | Smoothing per line              | 1–4                |

### Resolution Trade-off

$$
\Delta f = \frac{F_s}{N}, \quad \Delta t = \frac{N}{F_s}
$$

You cannot improve both frequency and time resolution simultaneously
(uncertainty principle). Choose based on your analysis goal:

- **Narrowband signal identification** → large N (high freq resolution)
- **Fast burst detection** → small N (high time resolution)

## 4. Software Waterfall Features

| Software   | Waterfall Quality | Notes                          |
|------------|-------------------|--------------------------------|
| **SDR++**  | Excellent         | Smooth, configurable colours   |
| **GQRX**   | Good              | Adjustable speed and range     |
| **SDR#**   | Excellent         | Multiple zoom levels           |
| **GNU Radio** | Custom         | QT GUI Waterfall Sink block    |
| **Inspectrum** | Best for files | Offline analysis, measurements |

## 5. Practical Waterfall Analysis

### Identifying FM Broadcast

```
Frequency (MHz)
 98.0        98.1        98.2        98.3
  │           │           │           │
  │     ██████████████████████████    │
  │     █  ~200 kHz wide mono FM █    │
  │     █  + 19 kHz pilot tone   █    │
  │     █  + 38 kHz stereo sub   █    │
  │     ██████████████████████████    │
```

### Identifying ADS-B Bursts

```
                1090 MHz
                   │
 ───────░░░░░░░░░░█░░░░░░░░░░░──
 ───────░░░░░░░░░░░░░░░░░░░░░░──
 ───────░░░░░░█░░░░░░░░░░░░░░░──  ← short bursts
 ───────░░░░░░░░░░░░░█░░░░░░░░──     (112 μs each)
```

## 6. Recording Waterfall Data

```bash
# Record wideband IQ for later waterfall analysis
rtl_sdr -f 433920000 -s 2400000 -g 40 -n 24000000 capture.raw

# View in Inspectrum
inspectrum capture.raw
# Set sample rate to 2400000 in the UI
```

---

**See also**: [Spectrum Basics](Spectrum_Basics.md) | [Signal Identification](Signal_Identification.md) | [FFT & Spectrum](../04_DSP_Fundamentals/FFT_Spectrum.md)
