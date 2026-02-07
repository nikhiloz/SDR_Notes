# Decimation and Interpolation

> **Sample Rate Conversion** - Changing sample rates to match processing requirements.

---

## 1. Decimation (Downsample)

Reduce sample rate by factor M: keep every M-th sample after anti-alias filtering.

```
    DECIMATION BY M=4

    Input (2.4 MSPS):  ●─●─●─●─●─●─●─●─●─●─●─●─●─●─●─●
                                    │
                              Anti-alias LPF
                                    │
    Output (600 kSPS):  ●───────●───────●───────●
```

### Why Decimate in SDR?

| Reason | Example |
|--------|---------|
| Reduce CPU load | 2.4 MSPS → 240 kSPS = 10× less work for demod |
| Match audio rate | Eventually need 48 kHz for speakers |
| Noise reduction | Anti-alias LPF removes out-of-band noise |
| Reduce storage | Recording at lower rate saves disk |

---

## 2. Interpolation (Upsample)

Increase sample rate by factor L: insert L-1 zeros between samples, then smooth with LPF.

```
    INTERPOLATION BY L=4

    Input (48 kHz):    ●───────●───────●───────●
                                    │
                           Insert zeros
                                    │
    Zeros inserted:    ●─0─0─0─●─0─0─0─●─0─0─0─●
                                    │
                        Interpolation LPF
                                    │
    Output (192 kHz):  ●─●─●─●─●─●─●─●─●─●─●─●
```

---

## 3. Rational Resampling

When you need a non-integer ratio (e.g., 2.4 MSPS → 48 kHz = ratio 50:1, or 2.4M → 44.1k):

$$\text{Rational Resample} = \text{Interpolate by } L \text{, then Decimate by } M$$

$$f_{out} = f_{in} \times \frac{L}{M}$$

---

## 4. GNU Radio Blocks

| Block | Use |
|-------|-----|
| Rational Resampler | General L/M resampling |
| Keep 1 in N | Simple decimation (no filter!) |
| Freq Xlating FIR Filter | Tune + filter + decimate in one block |

---

## 5. Deep Dive Reference

- [dsp-tutorial-suite Ch 02 — Sampling & Aliasing](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/02-sampling-and-aliasing.md)

---

*See also: [Filters](Filters.md) | [FFT](FFT_Spectrum.md) | [Back to 04_DSP_Fundamentals](README.md)*
