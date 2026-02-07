# FFT and Spectrum Analysis

> **Fast Fourier Transform** - The algorithm that makes real-time spectrum displays possible.

---

## 1. What the FFT Does

The FFT converts a block of time-domain I/Q samples into frequency-domain bins:

```
    TIME DOMAIN  ──── FFT ────▶  FREQUENCY DOMAIN

    Amplitude                     Power (dB)
        │   ╱╲                       │
        │  ╱  ╲    ╱╲               │     ▐█▌
        │ ╱    ╲  ╱  ╲              │   ▐▌▐█▌▐▌
        │╱      ╲╱    ╲             │   ▐█▐█▌██▌
        └─────────────▶ t           └─────────────▶ f

    N samples in  →  N/2 + 1 unique frequency bins out
```

---

## 2. FFT in SDR Applications

| Application | FFT Role |
|-------------|----------|
| **Spectrum display** | Show power vs frequency in real-time |
| **Waterfall** | Consecutive FFTs stacked = time-frequency view |
| **Signal detection** | Find signals above noise floor |
| **Channel power** | Sum FFT bins over channel bandwidth |
| **Demodulation** | OFDM subcarrier extraction |
| **Filtering** | Overlap-add fast convolution |

---

## 3. Key Parameters

| Parameter | Meaning | Trade-off |
|-----------|---------|-----------|
| **FFT size (N)** | Points per FFT | Larger = finer resolution, slower update |
| **Sample rate (fs)** | Input rate | Determines total bandwidth |
| **Bin width** | $\Delta f = f_s / N$ | Resolution in Hz |
| **Window function** | Applied before FFT | Reduce spectral leakage (see below) |
| **Overlap** | % of overlapping blocks | Smoother display |
| **Averaging** | Average multiple FFTs | Reduce variance |

### Resolution vs Speed

| FFT Size | Bin Width (at 2.4 MSPS) | Update Rate |
|----------|------------------------|-------------|
| 256 | 9,375 Hz | Very fast |
| 1024 | 2,344 Hz | Fast |
| 4096 | 586 Hz | Medium |
| 16384 | 146 Hz | Slow |
| 65536 | 37 Hz | Very slow |

---

## 4. Windowing (Critical!)

Applying a window function before FFT reduces **spectral leakage** — energy from one signal bleeding into adjacent bins:

```
    WITHOUT WINDOW (Rectangular)    WITH WINDOW (Hamming)

    │   ▐█▌   ← Main signal        │   ▐█▌   ← Main signal
    │  ▐███▌                        │  ▐███▌
    │ ▐█████▌                       │   ▐█▌
    │▐███████▌  ← Leakage!         │
    │████████████                   │▄▄▄▄▄▄▄▄▄▄  ← Clean floor
    └──────────▶ f                  └──────────▶ f
```

---

## 5. Deep Dive Reference

For complete C FFT implementation (Cooley-Tukey Radix-2):
- [dsp-tutorial-suite Ch 07 — DFT Theory](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/07-dft-theory.md)
- [dsp-tutorial-suite Ch 08 — FFT Fundamentals](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/08-fft-fundamentals.md)
- [dsp-tutorial-suite Ch 09 — Window Functions](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/09-window-functions.md)

---

*See also: [Filters](Filters.md) | [Decimation](Decimation_Interpolation.md) | [Back to 04_DSP_Fundamentals](README.md)*
