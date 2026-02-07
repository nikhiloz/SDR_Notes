# FIR Filters

> **Finite Impulse Response** - Filters with guaranteed stability and linear phase, the workhorse of SDR.

---

## 1. FIR Structure

```
    TRANSVERSAL FIR FILTER (Direct Form)

    x[n] ──┬──────┬──────┬──────┬──────┬──▶
           │  z⁻¹ │  z⁻¹ │  z⁻¹ │  z⁻¹ │
           ▼      ▼      ▼      ▼      ▼
          ×b₀    ×b₁    ×b₂    ×b₃    ×b₄
           │      │      │      │      │
           └──┬───┴──┬───┴──┬───┴──┬───┘
              +      +      +      +
              └──────┬──────┘
                     ▼
                   y[n]

    y[n] = Σ b[k] · x[n-k],  k = 0..N-1
```

---

## 2. Design Methods

| Method | Approach | When to Use |
|--------|----------|-------------|
| **Windowed sinc** | Ideal LPF × window function | Simple, general purpose |
| **Parks-McClellan** | Optimal equiripple (Remez exchange) | Minimum taps for given spec |
| **Frequency sampling** | Specify desired freq response | Arbitrary response shapes |
| **Least squares** | Minimize error in least-squares sense | Weighted optimization |

### Windowed Sinc Example

$$h[n] = \frac{\sin(2\pi f_c (n - M/2))}{\pi (n - M/2)} \cdot w[n]$$

Where $w[n]$ is a window function (Hamming, Blackman, Kaiser, etc.)

---

## 3. Common Window Functions

| Window | Main Lobe Width | Sidelobe Level | Use |
|--------|----------------|----------------|-----|
| Rectangular | Narrowest | -13 dB | Max resolution |
| Hamming | Medium | -43 dB | General purpose |
| Blackman | Wide | -58 dB | High stopband |
| Kaiser (β=6) | Adjustable | -44 dB | Flexible |
| Kaiser (β=9) | Adjustable | -70 dB | High rejection |

---

## 4. SDR-Specific Considerations

- **Tap count vs CPU**: A 200-tap FIR at 2.4 MSPS = 480M multiply-accumulate/sec
- **Decimating FIR**: Compute output only for kept samples → saves N× CPU
- **Polyphase implementation**: Efficient for large decimation ratios
- **SIMD acceleration**: Use SSE/AVX for 4-8× speedup on x86

---

## 5. Deep Dive Reference

For complete C implementations with detailed comments, see:
- [dsp-tutorial-suite Ch 10 — FIR Filter Design](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/10-digital-filters.md)
- [dsp-tutorial-suite Ch 09 — Window Functions](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/09-window-functions.md)

---

*See also: [IIR Filters](IIR_Filters.md) | [Filters overview](Filters.md) | [Back to 04_DSP_Fundamentals](README.md)*
