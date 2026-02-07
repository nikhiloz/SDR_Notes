# Spurious Signals & Artifacts

> Identifying and mitigating receiver-generated artifacts: DC offset, harmonics, images, intermod, and RFI.

---

## 1. Common SDR Artifacts

```
 Power
   ▲
   │        ┌┐       ┌──┐       ┌┐
   │   ┌┐   ││       │  │       ││   ┌┐
   │   ││   ││       │  │       ││   ││
   │───┤├───┤├───────┤  ├───────┤├───┤├──
   └───┴┴───┴┴───────┴──┴───────┴┴───┴┴──► f
        ↑    ↑           ↑           ↑    ↑
      Image  Harm.     Signal      Harm. Image

   Harm. = Harmonic, Image = Image frequency
```

## 2. Artifact Types

### DC Offset (Centre Spike)

| Cause                  | Fix                              |
|------------------------|----------------------------------|
| ADC DC bias            | Enable DC removal in software    |
| IQ imbalance           | Calibrate IQ correction          |
| LO leakage             | Offset tune (shift centre freq)  |

```
Most SDR software has "DC remove" or "offset tuning":
  SDR++    → Source settings → DC Correction
  GQRX     → Input Controls → DC remove
  rtl_fm   → -E dc flag
  hackrf   → offset tuning in Soapy
```

### Image Frequencies

Caused by imperfect IQ balance — a mirror of the real signal appears on the
opposite side of the centre frequency.

$$
f_{image} = f_{LO} - (f_{signal} - f_{LO}) = 2f_{LO} - f_{signal}
$$

| Cause              | Fix                                |
|--------------------|------------------------------------|
| IQ gain mismatch   | Software IQ balance correction     |
| IQ phase mismatch  | Auto-calibration (SDR++ IQ corr.)  |
| Hardware limitation | Better SDR (Airspy, PlutoSDR)      |

### Harmonics

Integer multiples of strong signals appear as ghost signals.

$$
f_{harmonic} = n \times f_{fundamental}, \quad n = 2, 3, 4, \ldots
$$

| Source            | Example                             |
|-------------------|-------------------------------------|
| Strong local TX   | FM at 100 MHz → ghost at 200 MHz   |
| SDR internal clock | 28.8 MHz TCXO → harmonics at 57.6, 86.4 MHz |
| Switching PSU      | Harmonics every few MHz            |

**Fix**: Bandpass filter before SDR, reduce gain, move antenna

### Intermodulation Distortion (IMD)

When two strong signals mix in the receiver's nonlinear front-end:

$$
f_{IMD} = m \cdot f_1 \pm n \cdot f_2
$$

Third-order products ($2f_1 - f_2$ and $2f_2 - f_1$) are most problematic
because they fall close to the original signals.

| Cause              | Fix                                |
|--------------------|------------------------------------|
| Overloaded front-end| Reduce RF gain                    |
| No preselection    | Bandpass filter for target band    |
| Strong nearby TX   | Notch filter on interferer         |

## 3. External RFI Sources

| Source              | Frequency Range    | Signature              |
|---------------------|--------------------|------------------------|
| Switching PSU       | Broadband harmonics| Comb-like spurs        |
| USB 3.0             | 2.4 GHz area       | Wideband noise         |
| LED drivers         | Broadband          | Buzzing noise          |
| Ethernet/HDMI       | Harmonics of clock | Narrowband spurs       |
| Electric motors     | Broadband          | Buzzy, varying         |
| Plasma TV           | Broadband          | High noise floor       |

## 4. Diagnostic Procedure

```
Step 1: Disconnect antenna → attach 50Ω terminator
        ├─ Spurs gone? → External RFI (antenna picking up noise)
        └─ Spurs remain? → Internal to SDR / computer

Step 2: Try different USB port / add ferrite chokes
        ├─ Improved? → USB noise
        └─ No change? → SDR internal

Step 3: Try different USB cable / powered hub
        ├─ Improved? → Cable/power issue
        └─ No change? → SDR hardware limitation

Step 4: Try different computer
        ├─ Improved? → Computer-generated RFI
        └─ No change? → SDR hardware
```

## 5. Mitigation Summary

| Artifact         | Primary Fix                      | Secondary Fix        |
|------------------|----------------------------------|----------------------|
| DC spike         | DC removal / offset tuning       | —                    |
| Image            | IQ correction                    | Better SDR           |
| Harmonics        | Bandpass filter                  | Reduce gain          |
| IMD              | Reduce gain, add filter          | Better SDR (high IP3)|
| USB RFI          | Ferrite chokes, USB 2.0 port     | USB isolator         |
| Switching noise  | Linear PSU, distance from SDR    | Shielding            |

## 6. SDR Dynamic Range & IP3

| SDR              | Dynamic Range | IP3 (dBm) | Notes                |
|------------------|--------------|-----------|----------------------|
| RTL-SDR V3       | ~45 dB       | Low       | 8-bit ADC            |
| Airspy R2        | ~80 dB       | High      | Oversampling         |
| Airspy HF+       | ~110 dB      | Very high | HF specialist        |
| HackRF One       | ~50 dB       | Low       | 8-bit, wide BW       |
| PlutoSDR         | ~60 dB       | Medium    | 12-bit ADC           |

Higher dynamic range = better ability to handle strong + weak signals simultaneously.

---

**See also**: [Noise Floor](Noise_Floor.md) | [Spectrum Basics](Spectrum_Basics.md) | [Hardware Comparison](../02_Hardware/Hardware_Comparison.md)
