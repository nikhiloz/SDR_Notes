# RF Connector Types

> Quick reference for common RF connectors used with SDR equipment.

---

## 1. Common SDR Connectors

| Connector | Impedance | Freq Range  | Used By                  |
|-----------|-----------|-------------|--------------------------|
| **SMA**   | 50Ω       | DC–18 GHz   | RTL-SDR V3/V4, PlutoSDR |
| **MCX**   | 50Ω       | DC–6 GHz    | Some RTL-SDR sticks      |
| **BNC**   | 50Ω       | DC–4 GHz    | Lab equipment, Airspy    |
| **N-type**| 50Ω       | DC–11 GHz   | Outdoor antennas, USRP   |
| **Type-F**| 75Ω       | DC–1 GHz    | TV/DVB-T (not SDR native)|
| **UHF/SO-239** | 50Ω  | DC–300 MHz  | HF/VHF amateur antennas  |
| **MMCX**  | 50Ω       | DC–6 GHz    | Some SDR boards          |

## 2. Connector Details

### SMA (Sub-Miniature A)

```
  ┌─────┐
  │     │ ← 6.35 mm hex nut
  │  ●  │ ← centre pin
  │     │
  └──┬──┘
     │ ← thread (1/4-36 UNS)
```

- **Most common SDR connector**
- Male: centre pin, external thread
- Female: centre socket, internal thread
- RP-SMA (reverse polarity): pin/socket swapped — **NOT interchangeable**

> **Warning**: WiFi equipment often uses RP-SMA. An RP-SMA antenna
> will NOT mate with a standard SMA SDR port.

### BNC (Bayonet Neill-Concelman)

```
  ┌─────┐
  │  ●  │ ← centre pin
  │     │
  └─┬┬──┘
    ││ ← bayonet twist-lock
```

- Quick connect / disconnect
- Common on oscilloscopes, spectrum analysers
- Airspy R2 uses BNC

### N-Type

```
  ┌───────┐
  │       │ ← 15.9 mm hex
  │   ●   │ ← centre pin
  │       │
  └───┬───┘
      │ ← thread (5/8-24 UNEF)
```

- Weather-resistant
- Higher power handling
- Standard for outdoor antenna installations

## 3. Adapter Guide

| From         | To          | Common Use                      |
|-------------|-------------|----------------------------------|
| SMA → BNC   |             | SDR to lab equipment             |
| SMA → N     |             | SDR to outdoor antenna           |
| MCX → SMA   |             | Old RTL-SDR to standard antenna  |
| F → SMA     |             | TV antenna to SDR                |
| UHF → SMA   |             | Ham antenna to SDR               |
| SMA → SMA   | barrel      | Cable extension                  |

> **Tip**: Every adapter introduces ~0.1–0.5 dB loss. Minimise adapters
> in the signal path.

## 4. Gender & Polarity

```
Male (plug):     pin protrudes, external thread
Female (jack):   socket receives, internal thread

Standard SMA:    male has pin + external thread
Reverse SMA:     male has socket + external thread (WiFi only)
```

| Connector | Male Has | Female Has |
|-----------|----------|------------|
| SMA       | Pin      | Socket     |
| RP-SMA    | Socket   | Pin        |
| BNC       | Pin      | Socket     |
| N-type    | Pin      | Socket     |

## 5. Buying Tips

- Buy from reputable sellers (avoid cheap brass-plated connectors)
- Gold-plated contacts have lower insertion loss
- Torque SMA connectors to 5 in-lb (use wrench, not pliers)
- Replace damaged connectors — a worn connector degrades performance

---

**See also**: [Cable Loss](Cable_Loss.md) | [Antenna Reference](Antenna_Reference.md) | [Hardware Comparison](../02_Hardware/Hardware_Comparison.md)
