# Antenna Basics

> Antenna fundamentals for SDR — types, selection, and practical tips.

---

## 📖 How Antennas Work

An antenna converts electromagnetic waves into electrical signals (receive)
or electrical signals into electromagnetic waves (transmit).

```
    ANTENNA BASIC PRINCIPLE

    Electromagnetic Wave           Antenna              Coaxial Cable
    
    ～～～～～～～▶  ┌─────────────┐     ┌──────────────────┐
    ～～～～～～～▶  │   Metallic  │─────│  To SDR receiver │
    ～～～～～～～▶  │   Element   │     │  (50Ω coax)      │
    ～～～～～～～▶  └─────────────┘     └──────────────────┘
```

---

## 📏 Wavelength and Antenna Size

Antenna dimensions are related to wavelength:

$$\lambda = \frac{c}{f} = \frac{300}{f_{MHz}} \text{ meters}$$

A **quarter-wave** antenna has length:

$$L = \frac{\lambda}{4} = \frac{75}{f_{MHz}} \text{ meters}$$

| Frequency | Wavelength | Quarter-Wave | Application |
|-----------|-----------|--------------|-------------|
| 100 MHz | 3.0 m | 75 cm | FM Broadcast |
| 137 MHz | 2.19 m | 55 cm | NOAA Satellite |
| 433 MHz | 69 cm | 17 cm | ISM Band |
| 1090 MHz | 27.5 cm | 6.9 cm | ADS-B |
| 2.4 GHz | 12.5 cm | 3.1 cm | WiFi/Bluetooth |

---

## 🔧 Common Antenna Types

### For SDR Receivers

```
    ANTENNA TYPES

    MONOPOLE/WHIP     DIPOLE           V-DIPOLE (rabbit ears)
    
         │                 │                  ╱     ╲
         │            ─────┤─────            ╱       ╲
         │                 │                ╱         ╲
        ═══              ═════             ═══════════
       Ground           Balun/             Ground plane
       plane            feedpoint          (or none)


    DISCONE            YAGI              PARABOLIC
    
        ╱╲              ──── Director    ┌─────────┐
       ╱  ╲             ──── Director    │  ╱───╲  │
      ╱    ╲            ──┼─ Driven      │ │  ●  │ │
     ╱──────╲           ──── Reflector   │  ╲───╱  │
    ╱        ╲                           └─────────┘
    Wideband RX         Directional       High gain
```

| Type | Gain | BW | Directional | Best For |
|------|------|----|-------------|----------|
| Whip/Monopole | 2 dBi | Wide | No | General RX, included with SDR |
| Dipole | 2.15 dBi | Moderate | No | Specific frequency |
| V-Dipole | 3 dBi | Moderate | Somewhat | NOAA satellite |
| Discone | 2 dBi | Very wide | No | Wideband scanning |
| Yagi | 7-15 dBi | Narrow | Yes | Distant signals |
| QFH | 3 dBi | Moderate | Overhead | Satellite (circular pol) |
| Collinear | 5-8 dBi | Narrow | Omnidirectional | ADS-B, marine |
| Parabolic | 20+ dBi | Very narrow | Yes | Microwave, satellite |

---

## 📡 Antenna Selection Guide

| Use Case | Recommended Antenna | Why |
|----------|-------------------|-----|
| First test / general | Included whip | Good enough to start |
| FM broadcast | Telescopic dipole | Tune to ~75 cm each side |
| ADS-B aircraft | 1090 MHz collinear | Omnidirectional, tuned |
| NOAA satellite | V-dipole (137 MHz) | Easy to build, good for passes |
| ISM 433 MHz | 17 cm whip | Quarter-wave for 433 |
| Wideband scanning | Discone | Covers 25-1300 MHz |
| Weak distant signals | Yagi + LNA | Directional gain |

---

## ⚡ Impedance Matching

Most SDR systems use **50 Ω** impedance. Mismatched impedance causes
signal loss and reflections:

```
    IMPEDANCE MATCHING

    Antenna (50Ω) ──── Coax (50Ω) ──── SDR (50Ω)  ✅ Matched
    
    Antenna (75Ω) ──── Coax (50Ω) ──── SDR (50Ω)  ⚠️ Mismatch (small loss)
    
    Antenna (???Ω) ─── Coax (50Ω) ──── SDR (50Ω)  ❌ Bad match (significant loss)
```

---

## 🏗️ DIY Antennas

### Quarter-Wave Ground Plane (easiest build)

```
    QUARTER-WAVE GROUND PLANE

         ▲ Vertical element
         │  (L = 75/f_MHz meters)
         │
    ─────┼───── Radials (4×, same length, 45° down)
        ╱│╲
       ╱ │ ╲
      ╱  │  ╲
    
    Connect vertical to SMA center pin
    Connect radials to SMA ground
```

**For 1090 MHz ADS-B:** Vertical = 6.9 cm, Radials = 6.9 cm each.

### V-Dipole for NOAA Satellites

```
    V-DIPOLE FOR 137 MHz

              54 cm          54 cm
         ╱─────────    ─────────╲
        ╱                        ╲
       ╱  120° angle              ╲
      ╱                            ╲
     ●──────────────────────────────●
              Feedpoint
              (to coax)
    
    Point straight up for overhead satellite passes
```

---

## 🔗 Further Reading

- [02_Hardware/](../02_Hardware/README.md) — SDR hardware connectors
- [Reference/](../Reference/README.md) — Connector types, cable loss
- [08_Practical_Projects/](../08_Practical_Projects/README.md) — Projects using specific antennas
