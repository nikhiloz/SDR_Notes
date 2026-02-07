# Cable Loss Reference

> Coaxial cable attenuation data for common cable types at SDR frequencies.

---

## 1. Why Cable Loss Matters

Every metre of coax between antenna and SDR **attenuates the signal**. At higher
frequencies, loss increases significantly. This directly reduces your receiver's
effective sensitivity.

$$
P_{received} = P_{antenna} - L_{cable} \text{ (dB)}
$$

> **Golden rule**: Keep cable as short as possible, or place an LNA at the antenna.

## 2. Cable Loss Table (dB per 100 metres)

| Cable      | 100 MHz | 433 MHz | 900 MHz | 1090 MHz | 2.4 GHz |
|-----------|---------|---------|---------|----------|---------|
| RG-174     | 12      | 23      | 33      | 37       | 60      |
| RG-58      | 8       | 16      | 22      | 25       | 40      |
| RG-213     | 4       | 8       | 12      | 14       | 22      |
| LMR-240    | 4       | 8       | 11      | 13       | 21      |
| LMR-400    | 2.7     | 5       | 7       | 8        | 13      |
| LMR-600    | 1.7     | 3.3     | 4.4     | 5        | 8.5     |
| Ecoflex 15 | 1.4     | 2.8     | 4.0     | 4.5      | 7.5     |

## 3. Loss for Common Cable Lengths

### RG-58 (common, cheap)

| Length | 433 MHz | 1090 MHz |
|--------|---------|----------|
| 1 m    | 0.16 dB | 0.25 dB  |
| 3 m    | 0.48 dB | 0.75 dB  |
| 5 m    | 0.80 dB | 1.25 dB  |
| 10 m   | 1.60 dB | 2.50 dB  |
| 20 m   | 3.20 dB | 5.00 dB  |

### LMR-400 (recommended for outdoor runs)

| Length | 433 MHz | 1090 MHz |
|--------|---------|----------|
| 1 m    | 0.05 dB | 0.08 dB  |
| 5 m    | 0.25 dB | 0.40 dB  |
| 10 m   | 0.50 dB | 0.80 dB  |
| 20 m   | 1.00 dB | 1.60 dB  |
| 50 m   | 2.50 dB | 4.00 dB  |

## 4. Impact on Signal Reception

```
Example: ADS-B at 1090 MHz, 10 m cable run

With RG-58:  -2.5 dB loss  (signal is 56% of original power)
With LMR-400: -0.8 dB loss  (signal is 83% of original power)
Difference: 1.7 dB — could mean 30% more aircraft detected
```

## 5. When to Use an LNA

```
Without LNA:
  Antenna ──── 10m RG-58 (−2.5 dB) ──── SDR (NF=6 dB)
  System NF ≈ 8.5 dB

With LNA at antenna:
  Antenna ──── LNA (+20 dB, NF=0.5 dB) ──── 10m RG-58 (−2.5 dB) ──── SDR
  System NF ≈ 0.5 dB  (Friis: LNA dominates)
```

**Rule of thumb**: If cable loss exceeds **3 dB**, add an LNA at the antenna end.

## 6. Cable Selection Guide

| Scenario                 | Recommended Cable | Max Length |
|--------------------------|-------------------|-----------|
| Indoor desk to SDR       | RG-174 / RG-58   | 1–3 m     |
| Window to rooftop        | LMR-240           | 5–10 m    |
| Outdoor antenna install  | LMR-400           | 10–30 m   |
| Tower / long runs        | LMR-600           | 30–100 m  |
| Satellite downlink       | LMR-400 + LNA     | any       |

## 7. Connector Loss

Don't forget connector loss:

| Connector | Loss per pair |
|-----------|---------------|
| SMA       | ~0.1 dB       |
| N-type    | ~0.05 dB      |
| BNC       | ~0.1 dB       |
| UHF/PL-259| ~0.2 dB      |
| F-type    | ~0.1 dB       |

## 8. Calculating Total System Loss

$$
L_{total} = L_{cable} + L_{connectors} + L_{adapters} + L_{splitters}
$$

Example setup:
```
Antenna → N-female (0.05) → 10m LMR-400 (0.8 @ 1090MHz) →
  N-to-SMA adapter (0.1) → SMA jumper 0.5m (0.04) → SDR

Total = 0.05 + 0.80 + 0.10 + 0.04 = 0.99 dB
```

---

**See also**: [Connector Types](Connector_Types.md) | [Antenna Reference](Antenna_Reference.md) | [Noise Floor](../07_Spectrum_Analysis/Noise_Floor.md)
