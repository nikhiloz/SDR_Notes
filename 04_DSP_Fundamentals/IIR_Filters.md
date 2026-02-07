# IIR Filters

> **Infinite Impulse Response** - Recursive filters that achieve sharp cutoffs with very few coefficients.

---

## 1. IIR Structure

```
    IIR FILTER (Direct Form II Transposed)

    x[n] ──────▶(+)──── b₀ ────▶(+)──────▶ y[n]
                 ▲               ▲
                 │    z⁻¹        │    z⁻¹
                 │     │         │     │
                (+)◀─ b₁ ──(+)◀── -a₁
                 ▲         ▲
                 │   z⁻¹   │   z⁻¹
                 │    │    │    │
                 └── b₂ ──┘── -a₂

    y[n] = b₀x[n] + b₁x[n-1] + b₂x[n-2] - a₁y[n-1] - a₂y[n-2]
```

---

## 2. Classical IIR Design Types

| Type | Passband | Stopband | Transition | Use Case |
|------|----------|----------|------------|----------|
| **Butterworth** | Maximally flat | Gradual rolloff | Wide | Audio, general |
| **Chebyshev I** | Ripple | Monotonic | Medium | Sharper than Butterworth |
| **Chebyshev II** | Flat | Ripple | Medium | Flat passband needed |
| **Elliptic** | Ripple | Ripple | Narrowest | Minimum order for spec |
| **Bessel** | Flat | Gradual | Widest | Preserve waveform shape |

---

## 3. Biquad (Second-Order Section)

The **biquad** is the building block of practical IIR filters. Higher-order filters are implemented as a **cascade of biquads** (SOS — Second Order Sections) for numerical stability:

```
    CASCADE OF BIQUADS (SOS)

    x[n] ──▶ [Biquad 1] ──▶ [Biquad 2] ──▶ [Biquad 3] ──▶ y[n]

    Each biquad: H(z) = (b₀ + b₁z⁻¹ + b₂z⁻²) / (1 + a₁z⁻¹ + a₂z⁻²)
```

---

## 4. IIR vs FIR for SDR

| Aspect | IIR | FIR |
|--------|-----|-----|
| DC blocker | ✅ Perfect (1 biquad) | ❌ Needs many taps |
| Audio filtering | ✅ Few coefficients | Overkill |
| Channel selection | Non-linear phase issue | ✅ Linear phase preferred |
| Anti-alias decimation | Possible but tricky | ✅ Standard approach |
| Simple LPF/HPF | ✅ 2-6 coefficients | 50-200 taps |

---

## 5. Deep Dive Reference

For complete C implementations:
- [dsp-tutorial-suite Ch 11 — IIR Filter Design](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/11-iir-filter-design.md)
- [dsp-tutorial-suite Ch 12 — Filter Structures](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/12-filter-structures.md)

---

*See also: [FIR Filters](FIR_Filters.md) | [Filters overview](Filters.md) | [Back to 04_DSP_Fundamentals](README.md)*
