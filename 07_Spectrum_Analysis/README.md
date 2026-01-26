# Spectrum Analysis

> **Spectrum Analysis** - Visualizing and understanding the RF spectrum.

---

## 📖 Contents

| Document | Description |
|----------|-------------|
| [Spectrum_Basics.md](Spectrum_Basics.md) | Understanding spectrum displays |
| [Waterfall_Display.md](Waterfall_Display.md) | Waterfall/spectrogram interpretation |
| [Signal_Identification.md](Signal_Identification.md) | Identifying signals by shape |
| [Noise_Floor.md](Noise_Floor.md) | Understanding noise |
| [Spurious_Signals.md](Spurious_Signals.md) | Dealing with spurs |

---

## 📺 Spectrum Display Overview

### Understanding the Display

The following diagram shows a typical spectrum analyzer display:

```
    SPECTRUM ANALYZER DISPLAY
    
    Power (dBm)
    ▲
    │                              ┌─── Strong signal
    │                              │
    -40 │                            ▐█▌
        │                            ▐█▌
    -60 │           ▐█▌              ▐█▌     ▐█▌
        │          ▐██▌             ▐██▌   ▐███▌
    -80 │   ▐▌    ▐████▌    ▐▌     ▐████▌ ▐█████▌
        │  ▐█▌   ▐██████▌  ▐█▌    ▐██████▐███████▌
    -100│▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ ◄── Noise floor
        └──────────────────────────────────────────────▶ Frequency (MHz)
        88.0          92.0          96.0         100.0
                 FM BROADCAST BAND
```

### Key Elements

| Element | Description |
|---------|-------------|
| **Y-Axis** | Signal power in dBm or dB |
| **X-Axis** | Frequency (linear scale) |
| **Peaks** | Individual signals |
| **Noise Floor** | Background noise level |
| **Center Freq** | Middle of display |
| **Span** | Total bandwidth shown |

---

## 🌊 Waterfall Display

### Time-Frequency View

The waterfall shows how the spectrum changes over time:

```
    WATERFALL DISPLAY (SPECTROGRAM)
    
    Time    Frequency →
      │     ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
      │     ░░░░░░░░░░░▓▓▓▓░░░░░░░░░░░░░░░░ ← Burst started
      ▼     ░░░░░░░░░░░████░░░░░░░░░░░░░░░░
    Now     ░░░░░░░░░░░████░░░░░░░░░░░░░░░░
            ░░░░░░░░░░░████░░░░░░░░░░░░░░░░
            ░░░░░░░░░░░▓▓▓▓░░░░░░░░░░░░░░░░ ← Burst ended
            ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    Past    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    
    Color/Brightness = Signal Strength
    ░ = Weak    ▓ = Medium    █ = Strong
```

### Interpreting Patterns

| Pattern | Indicates |
|---------|-----------|
| Continuous horizontal line | Constant carrier |
| Dashed line | Pulsed/intermittent signal |
| Diagonal line | Frequency drift or sweep |
| Burst patterns | Data transmissions |
| Wide bands | Spread spectrum or noise |

---

## 🔍 Signal Identification

### Common Signal Shapes

The following diagram shows signal shapes by modulation type:

```
    SIGNAL SHAPES BY MODULATION
    
    FM BROADCAST (WFM)           AM SIGNAL
    
        ▐████████████▌               ▐█▌
        ▐████████████▌              ▐███▌
       ▐██████████████▌            ▐█████▌
      ▐████████████████▌           │     │
    ─────────────────────        ─────────────
           ~200 kHz                 ~10 kHz
           
    NFM (NARROWBAND FM)          SSB (SINGLE SIDEBAND)
    
           ▐████▌                      ▐████
           ▐████▌                     ▐████
          ▐██████▌                   ▐████
          ▐██████▌                  ▐████
    ─────────────────             ─────────────
           ~12.5 kHz                  ~3 kHz
           
    FSK (2-FSK)                  PSK (BPSK/QPSK)
    
         ▐█▌  ▐█▌                  ▐██████▌
         ▐█▌  ▐█▌                  ▐██████▌
        ▐██▌  ▐██▌                ▐████████▌
    ─────────────────            ─────────────
     Mark    Space               Main lobe + side lobes
```

### Signal Width Reference

| Signal Type | Typical Width |
|-------------|---------------|
| CW (Morse) | <500 Hz |
| SSB Voice | 2.4-3 kHz |
| AM Voice | 6-10 kHz |
| NFM Voice | 12.5-25 kHz |
| WFM Broadcast | 150-200 kHz |
| ADS-B | 2 MHz |
| Wi-Fi | 20/40 MHz |

---

## 📊 Noise Floor

### Understanding Noise

The noise floor represents the minimum detectable signal level:

```
    NOISE FLOOR CONCEPT
    
    Power
    ▲
    │
    │      ▐█▌                    Signal above noise
    │      ▐█▌                    ↓ (visible)
    │      ▐█▌     ▐█▌
    │     ▐███▌   ▐███▌
    │▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ ← Noise Floor
    │░░░░░░░░░░░░░░░░░░░░░░░░░░░
    │░░░░░░░░░░░░░░░░░░░░░░░░░░░   Signal below noise
    └─────────────────────────▶    (not visible)
                            Freq
```

### Factors Affecting Noise Floor

| Factor | Effect |
|--------|--------|
| **Temperature** | Higher temp = higher noise |
| **Bandwidth** | Wider BW = higher noise |
| **Amplifier NF** | Higher NF = higher noise |
| **Interference** | Raises apparent floor |
| **Sample rate** | Lower rate = lower noise (decimation gain) |

### Reducing Noise Floor

| Technique | Improvement |
|-----------|-------------|
| Use LNA (low noise amp) | 10-20 dB |
| Reduce bandwidth | 3 dB per halving |
| Average FFT frames | √N improvement |
| Shielding | Reduces interference |
| Antenna tuning | Better signal coupling |

---

## 🚫 Spurious Signals

### Common Spurs

The following diagram shows sources of spurious signals:

```
    SPURIOUS SIGNALS
    
    ┌────────────────────────────────────────────────────────┐
    │  Real    Image   Harmonic   Intermod   Local           │
    │  Signal  Spur    Spur       Product    Oscillator      │
    │    │       │        │          │          │            │
    │    ▼       ▼        ▼          ▼          ▼            │
    │   ▐█▌    ▐░▌      ▐░▌        ▐░▌        ▐░▌           │
    │   ▐█▌    ▐░▌      ▐░▌        ▐░▌        ▐░▌           │
    │   ▐█▌    ▐░▌      ▐░▌        ▐░▌        ▐░▌           │
    │───────────────────────────────────────────────────────│
    │   100    200      300        350        [varies]  MHz │
    └────────────────────────────────────────────────────────┘
    
    █ = Real signal    ░ = Spurious (fake)
```

### Identifying Spurs

| Spur Type | Characteristic |
|-----------|----------------|
| **Image** | Appears on opposite side of LO |
| **Harmonic** | Integer multiple of real signal |
| **Intermod** | Sum/difference of strong signals |
| **LO Leakage** | DC spike at center |
| **ADC Clock** | Related to sample rate |

### Dealing with Spurs

| Method | Application |
|--------|-------------|
| Change center freq | Shift spur out of view |
| Check with antenna off | Still there = internal |
| Use offset tuning | Avoid LO at center |
| Add filtering | Block strong interference |

---

## ⚙️ Spectrum Analyzer Settings

### Key Parameters

| Setting | Description | Trade-off |
|---------|-------------|-----------|
| **FFT Size** | Points per FFT | Resolution vs. speed |
| **Averaging** | Smooth display | Clarity vs. response time |
| **RBW** | Resolution bandwidth | Detail vs. sensitivity |
| **Span** | Frequency range shown | Overview vs. detail |
| **Ref Level** | Top of display | Scale to signal strength |

### Recommended Settings

| Use Case | FFT Size | Averaging | Span |
|----------|----------|-----------|------|
| Hunting signals | 1024 | 1-4 | Wide |
| Signal analysis | 4096+ | 10+ | Narrow |
| Weak signals | 4096+ | 50+ | Narrow |
| Fast signals | 256-512 | None | Medium |

---

*See individual topic pages for deep dives.*
