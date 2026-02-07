# Unit Conversions for RF & SDR

> Quick-reference conversion tables for power, voltage, frequency, and wavelength.

---

## 1. Power Conversions

### dBm ↔ Watts

$$
P(\text{dBm}) = 10 \log_{10}\left(\frac{P(\text{mW})}{1\,\text{mW}}\right)
$$

| dBm    | mW        | Watts      | Example                   |
|--------|-----------|------------|---------------------------|
| −30    | 0.001     | 1 μW       | Weak received signal      |
| −20    | 0.01      | 10 μW      | Typical received signal   |
| −10    | 0.1       | 100 μW     | Strong local signal       |
| 0      | 1.0       | 1 mW       | Reference level           |
| +3     | 2.0       | 2 mW       | —                         |
| +10    | 10        | 10 mW      | ISM 433 MHz max           |
| +17    | 50        | 50 mW      | Typical WiFi              |
| +20    | 100       | 100 mW     | Handheld radio            |
| +27    | 500       | 0.5 W      | —                         |
| +30    | 1000      | 1 W        | Mobile phone / LoRa max   |
| +37    | 5000      | 5 W        | HF amateur typical        |
| +40    | 10,000    | 10 W       | VHF amateur               |
| +47    | 50,000    | 50 W       | FM broadcast (low power)  |
| +60    | 1,000,000 | 1 kW       | Amateur max / broadcast   |

### Quick dB Rules

| Change  | Power Ratio | Voltage Ratio |
|---------|-------------|---------------|
| +3 dB   | ×2          | ×1.41         |
| +6 dB   | ×4          | ×2            |
| +10 dB  | ×10         | ×3.16         |
| +20 dB  | ×100        | ×10           |
| +30 dB  | ×1000       | ×31.6         |
| −3 dB   | ÷2          | ÷1.41         |
| −10 dB  | ÷10         | ÷3.16         |
| −20 dB  | ÷100        | ÷10           |

## 2. Frequency ↔ Wavelength

$$
\lambda = \frac{c}{f} = \frac{3 \times 10^8}{f(\text{Hz})} \text{ metres}
$$

| Frequency  | Wavelength  | Band   |
|-----------|------------|--------|
| 1 MHz     | 300 m      | MF     |
| 7 MHz     | 42.86 m    | HF     |
| 14 MHz    | 21.43 m    | HF     |
| 50 MHz    | 6.0 m      | VHF    |
| 100 MHz   | 3.0 m      | VHF    |
| 137 MHz   | 2.19 m     | VHF    |
| 162 MHz   | 1.85 m     | VHF    |
| 433 MHz   | 69.2 cm    | UHF    |
| 868 MHz   | 34.6 cm    | UHF    |
| 1090 MHz  | 27.5 cm    | UHF    |
| 1575 MHz  | 19.0 cm    | L-band |
| 2.4 GHz   | 12.5 cm    | S-band |
| 5.8 GHz   | 5.17 cm    | C-band |

## 3. Frequency Unit Conversions

| From       | To         | Multiply by   |
|-----------|------------|---------------|
| Hz        | kHz        | ÷ 1,000       |
| kHz       | MHz        | ÷ 1,000       |
| MHz       | GHz        | ÷ 1,000       |
| GHz       | MHz        | × 1,000       |

## 4. Voltage ↔ dB

$$
dB = 20 \log_{10}\left(\frac{V_2}{V_1}\right)
$$

| dBμV    | μV          | mV        |
|---------|-------------|-----------|
| 0       | 1           | 0.001     |
| 20      | 10          | 0.01      |
| 40      | 100         | 0.1       |
| 60      | 1,000       | 1.0       |
| 80      | 10,000      | 10.0      |
| 100     | 100,000     | 100.0     |
| 120     | 1,000,000   | 1000.0    |

### dBμV ↔ dBm (50Ω system)

$$
dBm = dB\mu V - 107
$$

## 5. Sample Rate & Bandwidth

| Sample Rate | Max Signal BW (Nyquist) | Bits/sec (8-bit) |
|------------|-------------------------|-------------------|
| 250 kHz    | 125 kHz                 | 0.5 MB/s          |
| 1 MHz      | 500 kHz                 | 2 MB/s            |
| 2.4 MHz    | 1.2 MHz                 | 4.8 MB/s          |
| 10 MHz     | 5 MHz                   | 20 MB/s           |
| 20 MHz     | 10 MHz                  | 40 MB/s           |
| 56 MHz     | 28 MHz                  | 112 MB/s          |

## 6. Temperature

| Kelvin | Celsius | Use                |
|--------|---------|---------------------|
| 290 K  | 17°C    | Standard noise calc |
| 300 K  | 27°C    | Room temperature    |
| 77 K   | −196°C  | Liquid nitrogen     |
| 4 K    | −269°C  | Cryogenic receivers |

### Thermal Noise

$$
P_{noise} = kTB = -174 + 10\log_{10}(B) \text{ dBm}
$$

Where $k = 1.38 \times 10^{-23}$ J/K, $T = 290$ K

---

**See also**: [Decibels & Power](../01_Fundamentals/Decibels_Power.md) | [Frequency Chart](Frequency_Chart.md) | [Noise Floor](../07_Spectrum_Analysis/Noise_Floor.md)
