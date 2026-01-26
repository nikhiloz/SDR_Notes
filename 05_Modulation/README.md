# 05_Modulation

> **Modulation Types** - How information is encoded onto radio signals.

---

## 📖 Contents

| Document | Description |
|----------|-------------|
| [AM.md](AM.md) | Amplitude Modulation |
| [FM.md](FM.md) | Frequency Modulation |
| [SSB.md](SSB.md) | Single Sideband |
| [FSK.md](FSK.md) | Frequency Shift Keying |
| [PSK.md](PSK.md) | Phase Shift Keying |
| [QAM.md](QAM.md) | Quadrature Amplitude Modulation |
| [OFDM.md](OFDM.md) | Orthogonal Frequency Division Multiplexing |

---

## 🎯 Modulation Overview

### Why Modulate?

The following table explains why modulation is necessary:

| Reason | Explanation |
|--------|-------------|
| **Frequency translation** | Move signal to desired RF frequency |
| **Antenna efficiency** | Higher frequencies radiate better |
| **Channel sharing** | Multiple signals on different frequencies |
| **Noise immunity** | Some modulations resist noise better |
| **Bandwidth efficiency** | Pack more data in less spectrum |

---

## 📊 Modulation Types

### Analog vs Digital

The following diagram categorizes modulation types:

```
                        MODULATION TYPES
                              │
            ┌─────────────────┼─────────────────┐
            │                 │                 │
         ANALOG            DIGITAL          ADVANCED
            │                 │                 │
    ┌───────┼───────┐   ┌─────┼─────┐          │
    │       │       │   │     │     │          │
   AM      FM      PM  ASK   FSK   PSK       OFDM
    │               │   │     │     │       Spread
   SSB            NFM  OOK  GFSK  QPSK      Spectrum
   DSB            WFM       AFSK  8PSK        QAM
```

### Comparison Table

The following table compares common modulation types:

| Modulation | Type | What Varies | Bandwidth | Noise Immunity | Complexity |
|------------|------|-------------|-----------|----------------|------------|
| **AM** | Analog | Amplitude | 2× audio | Poor | Low |
| **FM** | Analog | Frequency | 10-15× audio | Good | Low |
| **SSB** | Analog | Amplitude (one sideband) | 1× audio | Fair | Medium |
| **OOK** | Digital | Amplitude (on/off) | Low | Poor | Very Low |
| **FSK** | Digital | Frequency | Medium | Good | Low |
| **BPSK** | Digital | Phase (2 states) | Low | Good | Medium |
| **QPSK** | Digital | Phase (4 states) | Low | Good | Medium |
| **16-QAM** | Digital | Amplitude + Phase | Compact | Fair | High |
| **OFDM** | Digital | Multiple subcarriers | Efficient | Good | High |

---

## 📈 Visual Comparison

### Signal Representations

The following diagrams show how each modulation affects the signal:

```
    AMPLITUDE MODULATION (AM)
    
    Carrier:    ╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲
    
                    ╱──╲           ╱──╲
    Modulating:    ╱    ╲         ╱    ╲
                  ╱      ╲       ╱      ╲
    ─────────────╱        ╲─────╱        ╲───────
    
                ╱╲      ╱╲╱╲╱╲╱╲╱╲      ╱╲
    AM Output: ╱╲╱╲    ╱╲╱╲╱╲╱╲╱╲╱╲    ╱╲╱╲
               ╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲
    
    Envelope follows modulating signal
```

```
    FREQUENCY MODULATION (FM)
    
    Carrier:    ╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲
    
                    ╱──╲           ╱──╲
    Modulating:    ╱    ╲         ╱    ╲
                  ╱      ╲       ╱      ╲
    ─────────────╱        ╲─────╱        ╲───────
    
    FM Output:  ╱╲╱╲ ╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲ ╱╲╱╲
               ╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲
    
    Frequency varies with modulating signal (amplitude constant)
```

```
    PHASE SHIFT KEYING (BPSK)
    
    Data:      1    1    0    0    1    0    1
              ────────────────────────────────────
    
              ╱╲╱╲ ╱╲╱╲ ╲╱╲╱ ╲╱╲╱ ╱╲╱╲ ╲╱╲╱ ╱╲╱╲
    BPSK:     ╱╲╱╲ ╱╲╱╲ ╲╱╲╱ ╲╱╲╱ ╱╲╱╲ ╲╱╲╱ ╱╲╱╲
              ────────────────────────────────────
                     ▲         ▲         ▲
                   Phase     Phase     Phase
                   flip      flip      flip
    
    Phase changes 180° for each bit transition
```

---

## 📉 Constellation Diagrams

### Digital Modulation Constellations

The following diagrams show constellation patterns:

```
    BPSK                    QPSK                    16-QAM
    (1 bit/symbol)          (2 bits/symbol)         (4 bits/symbol)
    
         Q                       Q                       Q
         │                       │                       │
         │                  ● ─  │  ─ ●                  │  ● ● ● ●
         │                  01   │   00                  │  ● ● ● ●
    ●────┼────● I          ─────┼─────  I          ─────┼─────────  I
    1    │    0            ● ─  │  ─ ●                  │  ● ● ● ●
         │                  11   │   10                  │  ● ● ● ●
         │                       │                       │
    
    Each point = unique symbol
    More points = more bits per symbol = higher data rate
```

---

## 📊 Bandwidth Comparison

The following table shows typical bandwidth requirements:

| Modulation | Bandwidth Formula | Example (1 kHz audio/1 kbps data) |
|------------|-------------------|-----------------------------------|
| **AM (DSB)** | 2 × f_audio | 2 kHz |
| **SSB** | f_audio | 1 kHz |
| **FM (narrow)** | 2 × (Δf + f_audio) | ~8 kHz |
| **FM (wide)** | 2 × (75k + 15k) | ~180 kHz |
| **OOK/ASK** | ~2 × symbol_rate | ~2 kHz |
| **FSK** | 2 × Δf + bit_rate | ~4 kHz |
| **BPSK** | ~symbol_rate | ~1 kHz |
| **QPSK** | ~symbol_rate/2 | ~0.5 kHz |

---

## 🔧 SDR Demodulation

### Demodulation in Software

The following table shows how to demodulate each type in SDR:

| Modulation | SDR Demodulation Method |
|------------|------------------------|
| **AM** | Envelope detection: `abs(I + jQ)` |
| **FM** | Frequency discriminator: `d(phase)/dt` |
| **SSB** | Product detector with BFO |
| **FSK** | FM demod + slicer |
| **PSK** | Carrier recovery + decision |
| **QAM** | Carrier + clock recovery |

### GNU Radio Blocks

| Modulation | GNU Radio Block |
|------------|-----------------|
| AM | AM Demod |
| FM Narrow | NBFM Receive |
| FM Wide | WBFM Receive |
| BPSK | PSK Demod |
| FSK | GFSK Demod |
| GMSK | GMSK Demod |

---

## 📻 Common Uses

The following table shows where each modulation is used:

| Modulation | Common Applications |
|------------|---------------------|
| **AM** | AM broadcast, aviation VHF |
| **FM Wide** | FM broadcast |
| **FM Narrow** | VHF/UHF voice, amateur |
| **SSB** | HF voice, amateur, marine |
| **OOK** | 433 MHz remotes, simple sensors |
| **FSK** | Pagers (POCSAG), AFSK packet |
| **GFSK** | Bluetooth, DECT |
| **GMSK** | GSM cellular |
| **QPSK** | DVB-S, many digital modes |
| **16/64-QAM** | Cable modems, DVB-C, WiFi |
| **OFDM** | WiFi, LTE, DAB, DVB-T |

---

## 📐 Key Formulas

### AM
$$s(t) = [1 + m \cdot a(t)] \cos(2\pi f_c t)$$

### FM
$$s(t) = \cos\left(2\pi f_c t + 2\pi k_f \int a(\tau) d\tau\right)$$

### Bits per Symbol
$$\text{bits/symbol} = \log_2(M)$$

Where M = number of constellation points

### Symbol Rate
$$R_s = \frac{R_b}{\log_2(M)}$$

Where $R_b$ = bit rate

---

*See individual modulation pages for detailed explanations and examples.*
