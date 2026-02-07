# Automatic Gain Control (AGC)

> **AGC** - Automatically adjusting signal amplitude to maintain consistent levels despite varying input power.

---

## 1. Why AGC?

SDR receives signals ranging from -120 dBm (satellite) to -20 dBm (local transmitter). Without AGC, weak signals are inaudible and strong signals clip the ADC.

```
    WITHOUT AGC                      WITH AGC

    Input:   ─╱╲──────╱╲╲╲╲──      Input:   ─╱╲──────╱╲╲╲╲──
               │         │                    │         │
    Output:  ─╱╲──────╱╲╲╲╲──      Output:  ─╱╲──────╱╲──────
             Weak    LOUD!                  Even      Even
```

---

## 2. AGC Parameters

| Parameter | Meaning | Typical Value |
|-----------|---------|---------------|
| **Attack time** | How fast gain decreases for strong signal | 1–10 ms |
| **Decay time** | How fast gain increases for weak signal | 100–500 ms |
| **Reference level** | Target output amplitude | 0.5–1.0 |
| **Max gain** | Gain limit (prevents noise amplification) | 40–60 dB |
| **Hang time** | Delay before increasing gain after strong signal | 50–200 ms |

---

## 3. AGC in SDR Software

### GNU Radio
- `AGC` block (simple, fast)
- `AGC2` block (two time constants: attack + decay)
- `AGC3` block (three parameters)

### SDR# / GQRX
- AGC built into demodulator — select slow/medium/fast

---

## 4. Hardware vs Software AGC

| Level | Where | Purpose |
|-------|-------|---------|
| RF AGC | RTL-SDR tuner (R820T) | Prevent ADC overload |
| IF AGC | FPGA/firmware | Maximize ADC dynamic range |
| Digital AGC | DSP software | Normalize for demodulator/audio |

All three levels are needed for good SDR operation.

---

*See also: [DSP Overview](DSP_Overview.md) | [Back to 04_DSP_Fundamentals](README.md)*
