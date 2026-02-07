# Frequency Calibration

> Correcting PPM offset in SDR oscillators for accurate frequency measurement and reception.

---

## 1. Why Calibrate?

Every SDR has a local oscillator with a frequency error measured in **parts per million (PPM)**.
Uncalibrated, your SDR might be off by several kHz, causing:

- Missed narrowband signals
- Poor demodulation quality
- Incorrect frequency measurements
- Failed digital decoding (tight bandwidth protocols)

$$
f_{error} = f_{nominal} \times \frac{PPM}{10^6}
$$

Example: 100 MHz signal with +50 PPM offset → off by **5 kHz**

## 2. Oscillator Types

| Oscillator | Stability (PPM)  | Temp Coeff | Cost   | SDR Examples        |
|-----------|-------------------|------------|--------|---------------------|
| Crystal   | ±20–100           | High       | $0.50  | Cheap RTL-SDR       |
| TCXO      | ±0.5–2            | Low        | $3–10  | RTL-SDR V3/V4       |
| OCXO      | ±0.01–0.1         | Very low   | $30–200| Lab equipment        |
| GPSDO     | ±0.001            | Negligible | $50+   | USRP, custom builds  |

## 3. Calibration Methods

### Method 1: GSM Cell Tower (most convenient)

GSM base stations use precision oscillators (±0.05 PPM). Use them as a calibration
reference.

```bash
# Install kalibrate-rtl
sudo apt install kalibrate-rtl

# Scan for GSM base stations (use your region's band)
kal -s GSM900    # Europe, Asia, Africa
kal -s GSM850    # Americas

# Output example:
# chan: 82 (freq=946.4 MHz) power: 42341.54 offset: 23.456kHz
# Average absolute error: 24.812 ppm

# Use the PPM value in your SDR software
rtl_fm -f 100000000 -p 25 ...   # -p sets PPM correction
```

### Method 2: Known Frequency Reference

```bash
# Use a known signal:
# - FM broadcast station (±few Hz)
# - Airport ATIS (published frequency)
# - NIST WWV (2.5, 5, 10, 15, 20 MHz)
# - GPS L1 (1575.42 MHz)

# Tune to known frequency, measure offset in SDR software
# PPM = (measured_offset_Hz / tuned_frequency_Hz) × 1e6
```

### Method 3: rtl_test (thermal characterisation)

```bash
# Run for extended period to observe drift
rtl_test -p
# Shows PPM estimate that converges over time
# Wait at least 10 minutes for thermal stabilisation
```

## 4. Applying Correction

| Software    | How to Apply PPM                    |
|-------------|-------------------------------------|
| rtl_fm      | `-p PPM` flag                       |
| rtl_433     | `-p PPM` flag                       |
| GQRX        | Input Controls → Freq. correction   |
| SDR++       | Source → PPM Correction             |
| SDR#        | Source → Frequency Correction       |
| GNU Radio   | RTL-SDR Source → Freq. Corr. (ppm)  |

```bash
# Example: receiving FM with -24 PPM correction
rtl_fm -f 98300000 -p -24 -M wbfm -s 200000 -r 48000 - | aplay -r 48000 -f S16_LE
```

## 5. Temperature Effects

Crystal oscillators drift with temperature:

```
PPM offset
    ▲
 +50│        ╱
    │       ╱
  0 │──────╱────────  ← operating range sweet spot
    │     ╱
 -50│    ╱
    └──────────────► Temperature (°C)
       20  25  30  35
```

- Allow SDR to **warm up for 10–15 minutes** before calibrating
- TCXO-equipped SDRs (V3/V4) are much more stable
- Outdoor/temperature-varying environments need periodic recalibration

## 6. High-Precision Solutions

### GPSDO (GPS Disciplined Oscillator)

```
┌──────────┐    10 MHz ref    ┌──────────┐
│  GPS      │ ───────────────►│  SDR     │
│  Module   │    PPS          │  (ext    │
│  + OCXO   │ ───────────────►│   clock) │
└──────────┘                  └──────────┘
```

- Locks a local oscillator to GPS atomic clocks
- Achieves ±0.001 PPM or better
- Required for: coherent arrays, TDOA, precision measurement

### External 10 MHz Reference

SDRs with external clock input (USRP, LimeSDR, PlutoSDR):

```bash
# USRP: use external 10 MHz
uhd_usrp_probe --args "clock_source=external"
```

## 7. Verification

After calibration, verify with a known signal:

```bash
# Tune to a known AM/FM station or beacon
# Compare displayed frequency with published frequency
# Residual error should be < 1 kHz for most applications
# For digital protocols (DMR, P25): < 100 Hz preferred
```

---

**See also**: [Time Synchronisation](Time_Sync.md) | [Hardware Comparison](../02_Hardware/Hardware_Comparison.md) | [Spurious Signals](../07_Spectrum_Analysis/Spurious_Signals.md)
