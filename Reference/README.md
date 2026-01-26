# Reference

> **Quick Reference** - Frequency charts, conversions, and lookup tables.

---

## 📖 Contents

| Document | Description |
|----------|-------------|
| [Frequency_Chart.md](Frequency_Chart.md) | Frequency allocations and band plans |
| [Antenna_Reference.md](Antenna_Reference.md) | Antenna types and selection |
| [Connector_Types.md](Connector_Types.md) | RF connectors guide |
| [Unit_Conversions.md](Unit_Conversions.md) | dB, dBm, power conversions |
| [Cable_Loss.md](Cable_Loss.md) | Coax cable loss reference |

---

## 📻 Quick Frequency Reference

### Interesting Frequencies (North America)

The following table lists commonly monitored frequencies:

| Frequency | Signal | Mode | Notes |
|-----------|--------|------|-------|
| 530 kHz - 1.7 MHz | AM Broadcast | AM | Direct sampling mode |
| 88 - 108 MHz | FM Broadcast | WFM | Great first test |
| 108 - 118 MHz | Aircraft Nav | AM | VOR, ILS |
| 118 - 137 MHz | Aircraft Voice | AM | Air traffic control |
| 137 MHz | NOAA Satellites | FM | Weather images |
| 144 - 148 MHz | 2m Amateur | FM/SSB | Ham radio |
| 156.8 MHz | Marine Ch16 | FM | Distress/calling |
| 162.4 - 162.55 MHz | NOAA Weather | FM | Weather radio |
| 162.0 MHz | AIS | GMSK | Ship tracking |
| 406 MHz | EPIRB/SARSAT | - | Emergency beacons |
| 420 - 450 MHz | 70cm Amateur | FM | Ham radio |
| 433.92 MHz | ISM (EU) | OOK/FSK | Sensors, remotes |
| 462 - 467 MHz | FRS/GMRS | FM | Walkie-talkies |
| 902 - 928 MHz | ISM | Various | LoRa, sensors |
| 1090 MHz | ADS-B | PPM | Aircraft tracking |
| 1575.42 MHz | GPS L1 | BPSK | Navigation |

---

## 📐 Decibel Quick Reference

### Power Ratios

| Ratio | dB |
|-------|-----|
| 0.001 | -30 dB |
| 0.01 | -20 dB |
| 0.1 | -10 dB |
| 0.5 | -3 dB |
| 1 | 0 dB |
| 2 | +3 dB |
| 10 | +10 dB |
| 100 | +20 dB |
| 1000 | +30 dB |

### Common Power Levels

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
| 100 W | +50 dBm |

---

## 📡 Wavelength Calculator

$$\lambda = \frac{300}{f_{MHz}}$$ meters

### Common Frequencies

| Frequency | Wavelength | λ/4 Antenna |
|-----------|------------|-------------|
| 1 MHz | 300 m | 75 m |
| 10 MHz | 30 m | 7.5 m |
| 100 MHz | 3 m | 75 cm |
| 144 MHz | 2.08 m | 52 cm |
| 433 MHz | 69 cm | 17 cm |
| 915 MHz | 33 cm | 8.2 cm |
| 1090 MHz | 27.5 cm | 6.9 cm |
| 2.4 GHz | 12.5 cm | 3.1 cm |

---

## 🔌 Connector Quick Reference

| Connector | Impedance | Max Freq | Common Use |
|-----------|-----------|----------|------------|
| **SMA** | 50Ω | 18 GHz | Most SDRs |
| **BNC** | 50Ω | 4 GHz | Test equipment |
| **N-Type** | 50Ω | 11 GHz | Professional |
| **F-Type** | 75Ω | 1 GHz | TV, Cable |
| **MCX** | 50Ω | 6 GHz | RTL-SDR v3 |
| **UHF (PL-259)** | 50Ω | 300 MHz | Amateur radio |

---

## 📊 Sample Rate vs Bandwidth

| Sample Rate | Usable BW | Bits | Data Rate |
|-------------|-----------|------|-----------|
| 250 kSPS | ~200 kHz | 8 | 0.5 MB/s |
| 1 MSPS | ~800 kHz | 8 | 2 MB/s |
| 2 MSPS | ~1.6 MHz | 8 | 4 MB/s |
| 2.4 MSPS | ~2 MHz | 8 | 4.8 MB/s |
| 10 MSPS | ~8 MHz | 8 | 20 MB/s |
| 20 MSPS | ~16 MHz | 8 | 40 MB/s |

> Usable bandwidth ≈ 80% of sample rate due to filter roll-off

---

## 🌡️ Noise Floor Reference

### Thermal Noise Floor

$$N_0 = -174 \text{ dBm/Hz}$$ (at 290K)

### Noise Floor vs Bandwidth

| Bandwidth | Noise Floor |
|-----------|-------------|
| 1 Hz | -174 dBm |
| 1 kHz | -144 dBm |
| 10 kHz | -134 dBm |
| 100 kHz | -124 dBm |
| 1 MHz | -114 dBm |
| 10 MHz | -104 dBm |

---

## 🗺️ ITU Regions

| Region | Area | ISM 433 MHz | ISM 900 MHz |
|--------|------|-------------|-------------|
| **1** | Europe, Africa, Middle East | 433.05-434.79 MHz | 868-870 MHz |
| **2** | Americas | 433 MHz (limited) | 902-928 MHz |
| **3** | Asia, Pacific | Varies | Varies |

---

*Keep this reference handy while working with SDR!*
