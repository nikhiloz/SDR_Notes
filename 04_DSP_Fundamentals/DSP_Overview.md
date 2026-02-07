# DSP Overview for SDR

> **DSP in SDR** - How digital signal processing replaces analog circuits in software-defined radio.

---

## 1. What is DSP?

Digital Signal Processing is the mathematical manipulation of digitized signals. In SDR, DSP replaces bulky analog hardware (filters, mixers, demodulators) with software algorithms running on a CPU/FPGA/GPU.

```
    ANALOG RADIO vs SDR

    ANALOG:
    Antenna → Band Filter → Mixer → IF Filter → Detector → Audio Amp → Speaker
                              ↑
                          Local Osc.    ← All hardware, fixed function

    SDR:
    Antenna → LNA → ADC → [═══ ALL SOFTWARE ═══] → Speaker/Display
                          │                       │
                          │  Filter → Mix → Demod │
                          │  Resample → Decode    │
                          │  (Reconfigurable!)    │
                          └───────────────────────┘
```

---

## 2. DSP Processing Chain

The typical SDR DSP chain:

```
    I/Q Samples (from ADC)
         │
         ▼
    ┌──────────┐     Shift desired signal to baseband
    │  Mixing  │     x(n) · e^{-j2πf_c n/f_s}
    └────┬─────┘
         ▼
    ┌──────────┐     Remove out-of-band signals
    │ Filtering│     Low-pass or band-pass FIR/IIR
    └────┬─────┘
         ▼
    ┌──────────┐     Reduce sample rate to match signal BW
    │Decimation│     Keep every M-th sample (with anti-alias LPF)
    └────┬─────┘
         ▼
    ┌──────────┐     Extract information from signal
    │  Demod   │     AM: |s(n)|   FM: d(∠s(n))/dt
    └────┬─────┘
         ▼
    Audio / Data Output
```

---

## 3. Key DSP Operations Summary

| Operation | What It Does | SDR Example |
|-----------|-------------|-------------|
| **Mixing** | Frequency shift | Tune to a channel |
| **Filtering** | Frequency selection | Isolate one FM station |
| **Decimation** | Reduce sample rate | 2.4 MSPS → 48 kHz |
| **Interpolation** | Increase sample rate | Upsampling for output |
| **FFT** | Time → frequency | Spectrum/waterfall display |
| **Demodulation** | Extract info | AM/FM/SSB audio |
| **AGC** | Level normalize | Handle weak + strong signals |
| **Correlation** | Pattern matching | Sync word detection |

---

## 4. Relation to dsp-tutorial-suite

For rigorous, code-level DSP implementations in C, see the companion repository:
[**dsp-tutorial-suite**](https://github.com/nikhiloz/dsp-tutorial-suite) — 30 chapters from signals & sequences through adaptive filters, with paired theory + runnable C code.

| SDR_Notes Section | dsp-tutorial-suite Chapter |
|-------------------|---------------------------|
| This file (DSP Overview) | [Ch 00 — Overview](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/00-overview.md) |
| [Filters](Filters.md) | [Ch 10 — FIR Filters](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/10-digital-filters.md) |
| [FIR Filters](FIR_Filters.md) | [Ch 10](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/10-digital-filters.md) |
| [IIR Filters](IIR_Filters.md) | [Ch 11 — IIR Design](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/11-iir-filter-design.md) |
| [FFT](FFT_Spectrum.md) | [Ch 07–08 — DFT & FFT](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/08-fft-fundamentals.md) |
| [Decimation](Decimation_Interpolation.md) | [Ch 02 — Sampling](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/02-sampling-and-aliasing.md) |

---

*See also: [Filters](Filters.md) | [FFT](FFT_Spectrum.md) | [Back to 04_DSP_Fundamentals](README.md)*
