# SDR Hardware Comparison

> **Full comparison** of all major SDR platforms across specifications, features, and use cases.

---

## 1. Master Specifications Table

| SDR | Freq Range | Instant BW | ADC Bits | TX | Duplex | Interface | Price |
|-----|------------|-----------|----------|-----|--------|-----------|-------|
| **RTL-SDR v3** | 24–1766 MHz | 2.4 MHz | 8 | ❌ | — | USB 2.0 | ~$30 |
| **RTL-SDR v4** | 24–1766 MHz | 2.4 MHz | 8 | ❌ | — | USB 2.0 | ~$40 |
| **Airspy Mini** | 24–1800 MHz | 6 MHz | 12 | ❌ | — | USB 2.0 | ~$100 |
| **Airspy HF+** | 0.5k–31M, 60–260M | 768 kHz | 18* | ❌ | — | USB 2.0 | ~$170 |
| **SDRPlay RSP1A** | 1k–2000 MHz | 10 MHz | 14 | ❌ | — | USB 2.0 | ~$110 |
| **SDRPlay RSPdx** | 1k–2000 MHz | 10 MHz | 14 | ❌ | — | USB 2.0 | ~$220 |
| **HackRF One** | 1–6000 MHz | 20 MHz | 8 | ✅ | Half | USB 2.0 | ~$300 |
| **PlutoSDR** | 325–3800 MHz† | 20 MHz | 12 | ✅ | Full | USB 2.0 | ~$150 |
| **LimeSDR Mini** | 10–3500 MHz | 30 MHz | 12 | ✅ | Full | USB 3.0 | ~$200 |
| **LimeSDR** | 100k–3800 MHz | 61 MHz | 12 | ✅ | Full | USB 3.0 | ~$300 |
| **USRP B200** | 70–6000 MHz | 56 MHz | 12 | ✅ | Full | USB 3.0 | ~$1,200 |
| **USRP B210** | 70–6000 MHz | 56 MHz | 12 | ✅ | Full | USB 3.0 | ~$2,300 |

> \* Effective bits via oversampling  
> † Hackable to 70–6000 MHz

---

## 2. Selection by Use Case

```
    SDR SELECTION FLOWCHART

    Start
      │
      ▼
    Need TX? ──── No ────▶ Budget?
      │                      │
     Yes               ┌─────┼──────┐
      │                ▼     ▼      ▼
      ▼             <$50   <$150  <$250
    Budget?         RTL-SDR  Airspy  SDRPlay
      │                      Mini   RSP1A
  ┌───┼──────┐
  ▼   ▼      ▼
<$200 <$400  $1k+
Pluto HackRF  USRP
      Lime    B200
```

| Use Case | Best Choice | Why |
|----------|-------------|-----|
| First SDR / learning | RTL-SDR v3/v4 | Cheapest, huge community |
| High-quality VHF/UHF RX | Airspy Mini | Best dynamic range per $ |
| HF / shortwave | SDRPlay RSP1A or Airspy HF+ | Low freq coverage, high bits |
| Learning TX/RX | PlutoSDR | Cheapest full duplex |
| Widest freq range TX/RX | HackRF One | 1–6 GHz, half duplex |
| MIMO / full duplex | LimeSDR | 2×2, open source |
| Research / professional | USRP B200/B210 | Industry standard, UHD |
| Cellular (srsRAN / OAI) | USRP B210 or LimeSDR | Full duplex + MIMO |
| Remote / network SDR | Airspy + SpyServer | Low-bandwidth streaming |

---

## 3. Dynamic Range Comparison

| SDR | ADC Bits | Effective ENOB | Approx SFDR |
|-----|----------|----------------|-------------|
| RTL-SDR | 8 | ~7 | ~50 dB |
| HackRF | 8 | ~7 | ~50 dB |
| Airspy Mini | 12 | ~13 (oversampled) | ~80 dB |
| SDRPlay RSP1A | 14 | ~12 | ~75 dB |
| PlutoSDR | 12 | ~11 | ~70 dB |
| LimeSDR | 12 | ~10 | ~65 dB |
| USRP B200 | 12 | ~11 | ~70 dB |

---

## 4. Connector Summary

| SDR | RF Connector | Data Connector |
|-----|-------------|----------------|
| RTL-SDR v3 | MCX | USB-A |
| RTL-SDR v4 | SMA | USB-A |
| Airspy Mini | SMA | Micro USB |
| SDRPlay RSP1A | SMA | Micro USB |
| HackRF One | SMA | Micro USB |
| PlutoSDR | SMA (×2) | Micro USB |
| LimeSDR Mini | SMA (×2) | USB-C / USB 3.0 |
| USRP B200 | SMA (×2) | USB 3.0 |

---

## 5. Software Compatibility Matrix

| SDR | SDR# | GQRX | SDR++ | GNU Radio | SDRangel |
|-----|------|------|-------|-----------|----------|
| RTL-SDR | ✅ | ✅ | ✅ | ✅ | ✅ |
| Airspy | ✅ | ✅ | ✅ | ✅ | ✅ |
| SDRPlay | ❌ | ✅* | ✅ | ✅* | ✅ |
| HackRF | ✅ | ✅ | ✅ | ✅ | ✅ |
| PlutoSDR | ❌ | ✅ | ✅ | ✅ | ✅ |
| LimeSDR | ❌ | ✅* | ✅ | ✅ | ✅ |
| USRP | ❌ | ✅* | ✅ | ✅ | ✅ |

> \* Via SoapySDR bridge

---

*See also: Individual hardware pages for detailed setup guides | [Back to 02_Hardware](README.md)*
