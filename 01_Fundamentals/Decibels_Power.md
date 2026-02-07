# Decibels & Power

> Understanding dB, dBm, and power calculations — the universal language of RF engineering.

---

## 📖 What are Decibels?

Decibels (dB) express **ratios** on a logarithmic scale. In RF/SDR work,
everything is measured in dB because signal levels span enormous ranges.

$$\text{dB} = 10 \log_{10}\left(\frac{P_{out}}{P_{in}}\right)$$

For voltage ratios:

$$\text{dB} = 20 \log_{10}\left(\frac{V_{out}}{V_{in}}\right)$$

---

## 📊 Quick dB Reference

| Power Ratio | dB | Meaning |
|-------------|------|---------|
| 0.001 | -30 dB | 1/1000th power |
| 0.01 | -20 dB | 1/100th power |
| 0.1 | -10 dB | 1/10th power |
| 0.5 | -3 dB | Half power |
| 1 | 0 dB | No change |
| 2 | +3 dB | Double power |
| 10 | +10 dB | 10× power |
| 100 | +20 dB | 100× power |
| 1000 | +30 dB | 1000× power |

### The "3 dB Rule"

- **+3 dB** = double the power
- **-3 dB** = half the power
- **+10 dB** = 10× the power

You can combine these: +13 dB = +10 dB + 3 dB = 10× × 2× = 20× power.

---

## ⚡ dBm — Absolute Power

**dBm** is power relative to 1 milliwatt:

$$P_{dBm} = 10 \log_{10}\left(\frac{P}{1 \text{ mW}}\right)$$

| Power | dBm |
|-------|-----|
| 1 pW | -90 dBm |
| 1 nW | -60 dBm |
| 1 μW | -30 dBm |
| 1 mW | 0 dBm |
| 10 mW | +10 dBm |
| 100 mW | +20 dBm |
| 1 W | +30 dBm |
| 10 W | +40 dBm |

### Typical Signal Levels in SDR

```
    SIGNAL LEVELS (approximate)

    +50 dBm ─── FM broadcast transmitter (100 kW EIRP)
    +40 dBm ─── 
    +30 dBm ─── Cell tower
    +20 dBm ─── WiFi router
    +10 dBm ─── Walkie-talkie
     0  dBm ─── 1 mW reference
    -10 dBm ───
    -20 dBm ─── Strong local signal at SDR input
    -30 dBm ─── Moderate signal
    -40 dBm ───
    -50 dBm ─── Typical FM station at receiver
    -60 dBm ───
    -70 dBm ─── Weak but usable signal
    -80 dBm ─── 
    -90 dBm ─── Weak signal, needs good antenna
    -100 dBm ── Very weak, may be near noise floor
    -110 dBm ── RTL-SDR noise floor (typical)
    -120 dBm ──
    -130 dBm ── Professional receiver noise floor
    -174 dBm ── Thermal noise floor (1 Hz BW, 290K)
```

---

## 🔗 Link Budget

A link budget adds up gains and losses in dB:

```
    LINK BUDGET EXAMPLE

    ┌──────────┐  +30 dBm   ┌──────┐  -100 dB  ┌──────┐  +20 dB  ┌────────┐
    │ TX Power │───────────▶│ Path │──────────▶│ Ant  │────────▶│ Signal │
    │ 1 Watt   │            │ Loss │           │ Gain │         │ -50 dBm│
    └──────────┘            └──────┘           └──────┘         └────────┘

    +30 dBm - 100 dB + 20 dB = -50 dBm at receiver
```

---

## 📐 Conversion Formulas

| Conversion | Formula |
|-----------|---------|
| Watts → dBm | $P_{dBm} = 10 \log_{10}(P_W / 0.001)$ |
| dBm → Watts | $P_W = 10^{(P_{dBm}/10)} \times 0.001$ |
| dBm → dBW | $P_{dBW} = P_{dBm} - 30$ |
| Voltage → dBV | $V_{dBV} = 20 \log_{10}(V)$ |

---

## 🔗 Further Reading

- [Reference/](../Reference/README.md) — Quick reference tables
- [01_Fundamentals/RF_Basics.md](RF_Basics.md) — RF propagation and path loss
- [dsp-tutorial-suite Ch01](https://github.com/nikhiloz/dsp-tutorial-suite/blob/main/chapters/01-signals-and-sequences.md) — Signal representation in code
