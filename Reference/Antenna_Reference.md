# Antenna Reference

> Quick reference for antenna types, dimensions, and matching for common SDR frequencies.

---

## 1. Antenna Fundamentals

### Quarter-Wave Length Formula

$$
L = \frac{c}{4f} = \frac{300}{4 \times f_{MHz}} \text{ metres} = \frac{75}{f_{MHz}} \text{ metres}
$$

### Half-Wave Length

$$
L = \frac{c}{2f} = \frac{150}{f_{MHz}} \text{ metres}
$$

## 2. Quarter-Wave Dimensions by Frequency

| Frequency   | Use               | λ/4 Length | Antenna Type       |
|-------------|-------------------|------------|--------------------|
| 137 MHz     | NOAA satellites    | 54.7 cm    | V-dipole, QFH      |
| 162 MHz     | AIS / Marine       | 46.3 cm    | Whip + ground plane |
| 433 MHz     | ISM band           | 17.3 cm    | Whip, Yagi          |
| 868 MHz     | LoRa (EU/India)    | 8.6 cm     | Whip, patch         |
| 1090 MHz    | ADS-B              | 6.9 cm     | Collinear, GP       |
| 1575 MHz    | GPS L1             | 4.8 cm     | Patch, helix        |

## 3. Common Antenna Types

### Whip / Monopole

```
     ↑ λ/4 element
     │
     │
  ───┼───  Ground plane (radials or PCB)
     │
    Coax
```

- **Gain**: ~2.15 dBi (over ground plane)
- **Pattern**: Omnidirectional (horizontal), donut-shaped
- **Polarisation**: Vertical
- **Best for**: General scanning, ISM, AIS, airband

### Dipole

```
  ←── λ/4 ──→        ←── λ/4 ──→
  ─────────────┤balun├─────────────
               │     │
             coax to SDR
```

- **Gain**: ~2.15 dBi
- **Pattern**: Omnidirectional (perpendicular to axis)
- **Best for**: HF/VHF reception, FM broadcast

### V-Dipole (Rabbit Ears)

```
     ╲           ╱
      ╲  120°   ╱
  λ/4  ╲       ╱  λ/4
        ╲     ╱
         ╲   ╱
          ╲ ╱
           V  → coax
```

- **Gain**: ~3 dBi zenith
- **Pattern**: Broadside / overhead
- **Best for**: NOAA APT weather satellites

### Discone

```
          ╱ disk (λ/4 @ lowest freq)
    ─────╱─────
         │
        ╲│╱
         ╲  cone element
          ╲
           ╲
```

- **Gain**: ~0 dBi
- **Bandwidth**: Very broadband (10:1 ratio)
- **Best for**: Wideband scanning, monitoring multiple bands

### Yagi-Uda

```
  ──── Director 1 (shorter)
  ───── Director 2
  ─────── Driven element (λ/2)
  ────────── Reflector (longer)
              │
           boom → mount
```

- **Gain**: 6–15 dBi (depends on elements)
- **Pattern**: Directional
- **Best for**: Weak signal reception, satellite tracking, DX

### QFH (Quadrifilar Helix)

- Circular polarisation (matches satellites)
- Hemispherical pattern (horizon to zenith)
- Complex to build but excellent for satellite reception
- Plans: jcoppens.com/ant/qfh

### Collinear

```
     ↑ λ/2 element
     │
   ──┤── phasing stub
     │
     ↑ λ/2 element
     │
   ──┤── phasing stub
     │
     ↑ λ/2 element
     │
    Coax
```

- **Gain**: 5–9 dBi (more elements = more gain)
- **Pattern**: Omnidirectional, low angle
- **Best for**: ADS-B, AIS, long-range ground-based signals

## 4. Antenna Selection Guide

| Application          | Best Antenna       | Freq        | Indoor? |
|---------------------|--------------------|-------------|---------|
| FM broadcast        | Dipole / stock     | 88–108 MHz  | Yes     |
| Airband             | Whip / discone     | 118–137 MHz | Yes     |
| NOAA satellite      | V-dipole / QFH     | 137 MHz     | No      |
| AIS marine          | Whip / collinear   | 162 MHz     | No      |
| ISM 433 MHz         | Whip / Yagi        | 433 MHz     | Yes     |
| ADS-B aircraft      | Collinear / GP     | 1090 MHz    | No      |
| Wideband scanning   | Discone            | 25–1300 MHz | No      |

## 5. Impedance Matching

Most SDR inputs are **50Ω**. Match your antenna:

| Antenna         | Impedance  | Match Needed?       |
|-----------------|-----------|---------------------|
| Monopole + GP   | ~35Ω      | Close enough        |
| Dipole           | ~73Ω     | Balun recommended   |
| Yagi             | ~50Ω     | Usually matched     |
| Discone          | ~50Ω     | Usually matched     |
| Half-wave (end)  | ~2500Ω   | Transformer needed  |

### SWR (Standing Wave Ratio)

$$
SWR = \frac{1 + |\Gamma|}{1 - |\Gamma|}, \quad \Gamma = \frac{Z_L - Z_0}{Z_L + Z_0}
$$

| SWR   | Power Loss | Acceptable?           |
|-------|-----------|------------------------|
| 1.0   | 0%        | Perfect match          |
| 1.5   | 4%        | Excellent              |
| 2.0   | 11%       | Good                   |
| 3.0   | 25%       | Marginal               |
| 5.0+  | 44%+      | Poor — fix the match   |

## 6. Coax Cable

| Type      | Loss at 1 GHz | Impedance | Use                    |
|-----------|--------------|-----------|------------------------|
| RG-174    | 33 dB/100m   | 50Ω       | Short jumpers only     |
| RG-58     | 22 dB/100m   | 50Ω       | Short runs (<5m)       |
| RG-213    | 12 dB/100m   | 50Ω       | Medium runs            |
| LMR-240   | 11 dB/100m   | 50Ω       | Medium runs (outdoor)  |
| LMR-400   | 7 dB/100m    | 50Ω       | Long runs (recommended)|
| LMR-600   | 4.4 dB/100m  | 50Ω       | Very long runs         |

> **Rule**: Keep coax as short as possible. Place LNA at the antenna end.

---

**See also**: [Connector Types](Connector_Types.md) | [Cable Loss](Cable_Loss.md) | [Antenna Basics](../01_Fundamentals/Antenna_Basics.md)
