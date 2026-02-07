# Digital Filters for SDR

> **Filtering** - The most fundamental DSP operation: selecting desired frequencies and rejecting unwanted ones.

---

## 1. Filter Types

```
    FILTER TYPES — FREQUENCY RESPONSE

    LOW-PASS (LPF)             HIGH-PASS (HPF)
    │████████                  │        ████████
    │████████                  │        ████████
    │████████▓▓                │      ▓▓████████
    │████████░░░               │   ░░░████████
    └──────────▶ f             └──────────▶ f
         fc                         fc

    BAND-PASS (BPF)            BAND-STOP (NOTCH)
    │    ████████              │████████    ████████
    │  ▓▓████████▓▓           │████████▓▓▓▓████████
    │░░░████████░░░            │████████░░░░████████
    └──────────▶ f             └──────────▶ f
       f1    f2                   f1    f2
```

---

## 2. Filter Applications in SDR

| Filter Type | SDR Use Case |
|-------------|-------------|
| **Low-pass** | Anti-alias before decimation; baseband channel selection |
| **Band-pass** | Select a specific channel from wideband I/Q |
| **High-pass** | Remove DC offset |
| **Notch** | Remove narrowband interference (e.g., birdie) |

---

## 3. Key Parameters

| Parameter | Meaning | Trade-off |
|-----------|---------|-----------|
| **Cutoff frequency** | Where filter starts attenuating | Sets passband width |
| **Transition width** | Roll-off region (pass → stop) | Narrow = more taps = more CPU |
| **Stopband attenuation** | How much rejection in stopband | Higher = more taps |
| **Passband ripple** | Variation within passband | Lower = more taps |
| **Order / # taps** | Filter complexity | More = sharper but slower |
| **Group delay** | Time delay through filter | FIR: constant; IIR: varies |

---

## 4. FIR vs IIR Quick Comparison

| Property | FIR | IIR |
|----------|-----|-----|
| Stability | Always stable | Can be unstable |
| Phase | Linear phase possible | Non-linear phase |
| # Coefficients | Many (50-500 typical) | Few (5-20 typical) |
| CPU cost | Higher | Lower |
| Design | Windowed sinc, Parks-McClellan | Butterworth, Chebyshev, Elliptic |
| Best for SDR | Channel filtering, anti-alias | Audio EQ, simple LPF |

See detailed pages: [FIR Filters](FIR_Filters.md) | [IIR Filters](IIR_Filters.md)

---

## 5. GNU Radio Filter Blocks

| Block | Type | Use |
|-------|------|-----|
| Low Pass Filter | FIR | Channel selection |
| Band Pass Filter | FIR | Isolate signal |
| Band Reject Filter | FIR | Remove interference |
| Freq Xlating FIR Filter | FIR | Tune + filter (combined) |
| IIR Filter | IIR | Simple filtering |
| DC Blocker | IIR | Remove DC offset |

---

*See also: [FIR Filters](FIR_Filters.md) | [IIR Filters](IIR_Filters.md) | [Back to 04_DSP_Fundamentals](README.md)*
