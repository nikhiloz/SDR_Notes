# Phase Shift Keying (PSK)

> **PSK** - Digital modulation that encodes data in the phase of the carrier signal.

---

## 1. Concept

```
    BPSK (Binary Phase Shift Keying)

    Data:     1     1     0     0     1     0
             ─────────────────────────────────
    Signal:  ╱╲╱╲  ╱╲╱╲ ╲╱╲╱  ╲╱╲╱  ╱╲╱╲ ╲╱╲╱
                        ▲           ▲      ▲
                      180°        180°   180°
                      flip        flip   flip

    '1' = 0° phase    '0' = 180° phase
```

---

## 2. PSK Variants

| Variant | Phase States | Bits/Symbol | Bandwidth Efficiency |
|---------|-------------|-------------|---------------------|
| **BPSK** | 2 (0°, 180°) | 1 | Low |
| **QPSK** | 4 (0°, 90°, 180°, 270°) | 2 | Medium |
| **8PSK** | 8 | 3 | High |
| **DPSK** | Differential (change in phase) | 1 | No carrier recovery needed |
| **π/4-DQPSK** | 4, offset by π/4 each symbol | 2 | DECT, TETRA |

---

## 3. Constellation Diagrams

```
    BPSK                    QPSK                    8PSK

         Q                       Q                       Q
         │                       │                  ●    │    ●
         │                  ●    │    ●            ● ────┼──── ●
    ●────┼────●  I         ─────┼─────  I          ● ────┼──── ●
    1    │    0            ●    │    ●                ●    │    ●
         │                       │                       │

    Each point = unique symbol (phase angle)
```

---

## 4. Demodulation

PSK demodulation requires:
1. **Carrier recovery** — recreate exact frequency/phase of carrier
2. **Symbol timing recovery** — know when each symbol starts
3. **Decision** — map I/Q point to nearest constellation point

In SDR (GNU Radio): `PSK Demod` block handles all three steps.

---

## 5. Common PSK Signals

| Signal | Modulation | Where |
|--------|-----------|-------|
| GPS L1 | BPSK | 1575.42 MHz |
| DVB-S (satellite TV) | QPSK | Ku-band |
| TETRA | π/4-DQPSK | VHF/UHF |
| Amateur digital modes | PSK31 (BPSK) | HF |

---

*See also: [FSK](FSK.md) | [QAM](QAM.md) | [Back to 05_Modulation](README.md)*
