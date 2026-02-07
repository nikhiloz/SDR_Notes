# Quadrature Amplitude Modulation (QAM)

> **QAM** - Modulation that varies both amplitude AND phase to pack more bits per symbol.

---

## 1. Concept

QAM combines AM and PSK — each symbol has a unique combination of amplitude and phase:

```
    16-QAM CONSTELLATION

              Q
              │
        ●  ●  │  ●  ●
              │
        ●  ●  │  ●  ●
    ──────────┼──────────  I
        ●  ●  │  ●  ●
              │
        ●  ●  │  ●  ●
              │

    16 points = 4 bits per symbol
    64-QAM = 64 points = 6 bits/symbol
    256-QAM = 256 points = 8 bits/symbol
```

---

## 2. QAM Orders

| Order | Points | Bits/Symbol | SNR Required | Use Case |
|-------|--------|-------------|-------------|----------|
| 4-QAM (= QPSK) | 4 | 2 | ~10 dB | Satellite, deep space |
| 16-QAM | 16 | 4 | ~16 dB | Cable modem, WiFi |
| 64-QAM | 64 | 6 | ~22 dB | DVB-C, WiFi |
| 256-QAM | 256 | 8 | ~28 dB | DOCSIS, WiFi 5/6 |
| 1024-QAM | 1024 | 10 | ~34 dB | WiFi 6 |

Higher order = more data per symbol but requires cleaner (higher SNR) channel.

---

## 3. Trade-off: Throughput vs Robustness

```
    ◀──── Higher data rate ──────────── More robust ────▶

    1024-QAM  256-QAM  64-QAM  16-QAM  QPSK   BPSK
       │         │        │       │       │      │
    10 bits   8 bits  6 bits  4 bits  2 bits  1 bit
    per sym   per sym per sym per sym per sym per sym
       │         │        │       │       │      │
    needs      needs   needs  needs   needs  needs
    ~34 dB    ~28 dB  ~22 dB ~16 dB  ~10 dB  ~7 dB
     SNR       SNR     SNR    SNR     SNR    SNR
```

---

## 4. Where QAM is Used

| Application | Typical QAM | Why |
|-------------|-------------|-----|
| Cable TV (DVB-C) | 64/256-QAM | Cable = clean channel |
| WiFi (802.11ac/ax) | Up to 1024-QAM | High throughput indoors |
| LTE/5G | Adaptive (QPSK to 256-QAM) | Adapts to channel conditions |
| DSL | DMT (many QAM subcarriers) | Each subcarrier adapts independently |

---

*See also: [PSK](PSK.md) | [OFDM](OFDM.md) | [Back to 05_Modulation](README.md)*
