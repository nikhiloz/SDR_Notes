# Advanced Topics

> **Advanced SDR** - Deep dives into advanced SDR concepts and techniques.

---

## 📖 Contents

| Document | Description |
|----------|-------------|
| [Phased_Arrays.md](Phased_Arrays.md) | Direction finding and beamforming |
| [Coherent_Receivers.md](Coherent_Receivers.md) | Phase-synchronized reception |
| [Time_Sync.md](Time_Sync.md) | Precision timing with GPS |
| [Frequency_Calibration.md](Frequency_Calibration.md) | PPM correction techniques |
| [Machine_Learning.md](Machine_Learning.md) | ML for signal classification |
| [Remote_SDR.md](Remote_SDR.md) | Network-attached SDR |
| [GNU_Radio_OOT.md](GNU_Radio_OOT.md) | Custom block development |

---

## 📡 Direction Finding

### Phased Array Concept

By using multiple antennas, you can determine signal direction:

```
    PHASED ARRAY DIRECTION FINDING
    
    Signal wavefront arriving at angle θ
    
                    ╲  ╲  ╲  ╲  ╲  ╲
                     ╲  ╲  ╲  ╲  ╲  ╲
                      ╲  ╲  ╲  ╲  ╲  ╲  ← Incoming wave
                       ╲  ╲  ╲  ╲  ╲  ╲
    ┌───────────────────────────────────────────────────┐
    │    │                                              │
    │    │  Ant 1     Ant 2     Ant 3     Ant 4        │
    │    ▼    │         │         │         │          │
    │    θ   (●)       (●)       (●)       (●)         │
    │         │    d    │    d    │    d    │          │
    │         └────┬────┴────┬────┴────┬────┘          │
    │              │         │         │               │
    │         ┌────┴────┐    │    ┌────┴────┐          │
    │         │ SDR #1  │    │    │ SDR #2  │          │
    │         └────┬────┘    │    └────┬────┘          │
    │              │         │         │               │
    │              └────────┬┴─────────┘               │
    │                       ▼                          │
    │              ┌─────────────────┐                 │
    │              │  DSP: Calculate │                 │
    │              │  phase delays   │                 │
    │              │  → Find angle   │                 │
    │              └─────────────────┘                 │
    └───────────────────────────────────────────────────┘
```

### Phase Difference to Angle

$$\theta = \arcsin\left(\frac{\Delta\phi \cdot \lambda}{2\pi \cdot d}\right)$$

Where:
- Δφ = Phase difference between antennas
- λ = Wavelength
- d = Antenna spacing

---

## 🔒 Coherent Reception

### What is Coherence?

Multiple SDRs sharing the same clock for phase-aligned sampling:

```
    COHERENT SDR SETUP
    
    ┌─────────────────────────────────────────────────────┐
    │                                                      │
    │    ┌───────────────┐                                │
    │    │  Reference    │─── 10 MHz Reference Clock      │
    │    │  Oscillator   │         │                      │
    │    │  (GPSDO/OCXO) │         │                      │
    │    └───────────────┘         │                      │
    │                              │                      │
    │         ┌────────────────────┼───────────────┐      │
    │         │                    │               │      │
    │         ▼                    ▼               ▼      │
    │    ┌─────────┐          ┌─────────┐    ┌─────────┐ │
    │    │  SDR 1  │          │  SDR 2  │    │  SDR 3  │ │
    │    │(master) │          │ (slave) │    │ (slave) │ │
    │    └────┬────┘          └────┬────┘    └────┬────┘ │
    │         │                    │               │      │
    │         └────────────────────┴───────────────┘      │
    │                         │                           │
    │                         ▼                           │
    │               ┌──────────────────┐                  │
    │               │ Phase-coherent   │                  │
    │               │ I/Q samples      │                  │
    │               └──────────────────┘                  │
    └─────────────────────────────────────────────────────┘
```

### Coherent SDR Hardware

| Device | Coherence Method |
|--------|-----------------|
| KerberosSDR | 4x RTL-SDR, shared clock |
| USRP X-series | External 10 MHz ref |
| PlutoSDR + mod | External clock mod |
| LimeSDR | 2 RX channels, 1 clock |

---

## ⏱️ Precision Timing

### GPS Disciplined Oscillator (GPSDO)

```
    GPSDO OPERATION
    
    ┌───────────────────────────────────────────────────────┐
    │                                                        │
    │    GPS Antenna                                         │
    │        │                                               │
    │        ▼                                               │
    │   ┌─────────┐     ┌─────────┐     ┌─────────────────┐ │
    │   │  GPS    │────▶│  PLL    │────▶│   10 MHz OCXO   │ │
    │   │Receiver │     │Control  │     │  (disciplined)  │ │
    │   └─────────┘     └─────────┘     └────────┬────────┘ │
    │        │                                   │          │
    │        │                                   ▼          │
    │   1PPS out                           10 MHz out       │
    │   (timing)                           (frequency)      │
    │                                                        │
    │   Accuracy: ±0.001 PPM (1 part per billion)           │
    └───────────────────────────────────────────────────────┘
```

### Timing Applications

| Application | Requirement |
|-------------|-------------|
| Direction finding | Phase alignment |
| TDOA location | Precise timestamps |
| Coherent reception | Shared clock |
| Long recordings | Drift-free |

---

## 🔧 Frequency Calibration

### PPM Offset

RTL-SDR and other receivers have frequency error:

$$f_{actual} = f_{displayed} \times (1 + \frac{PPM}{10^6})$$

### Calibration Methods

| Method | Accuracy | Notes |
|--------|----------|-------|
| GSM base station | ±1 PPM | Use Kalibrate-RTL |
| Known FM station | ±5 PPM | Tune to exact freq |
| GPSDO reference | <0.01 PPM | Best accuracy |
| WWV/WWVH | ±1 PPM | 2.5, 5, 10, 15 MHz |
| ADS-B @ 1090 MHz | ±1 PPM | Use dump1090 |

### Calibration Procedure

```
    CALIBRATION FLOW
    
    ┌───────────────────┐
    │ Find known signal │
    │ (GSM, FM, NOAA)   │
    ├───────────────────┤
            │
            ▼
    ┌───────────────────┐
    │ Measure offset    │
    │ Expected - Actual │
    ├───────────────────┤
            │
            ▼
    ┌───────────────────┐
    │ Calculate PPM     │
    │ offset/freq × 1M  │
    ├───────────────────┤
            │
            ▼
    ┌───────────────────┐
    │ Apply correction  │
    │ in software       │
    └───────────────────┘
```

---

## 🤖 Machine Learning for SDR

### Signal Classification

Using ML to automatically identify signals:

```
    ML SIGNAL CLASSIFICATION PIPELINE
    
    ┌───────────┐   ┌───────────┐   ┌───────────┐   ┌───────────┐
    │   I/Q     │   │  Feature  │   │    ML     │   │  Signal   │
    │  Samples  │──▶│ Extraction│──▶│  Model    │──▶│   Type    │
    └───────────┘   └───────────┘   └───────────┘   └───────────┘
                          │
                          ▼
                    ┌───────────┐
                    │ - FFT     │
                    │ - Cyclo   │
                    │ - Moments │
                    │ - Spectral│
                    └───────────┘
```

### Common Features

| Feature | Captures |
|---------|----------|
| FFT magnitude | Spectral shape |
| Higher-order stats | Modulation type |
| Cyclostationary | Periodic features |
| Time-frequency | Signal dynamics |
| I/Q histogram | Amplitude distribution |

### Models for SDR

| Model | Use Case |
|-------|----------|
| CNN | Spectrogram classification |
| RNN/LSTM | Sequential signal patterns |
| Random Forest | Feature-based classification |
| Autoencoders | Anomaly detection |

---

## 🌐 Remote SDR

### Network-Attached SDR

Access SDR hardware over the network:

```
    REMOTE SDR ARCHITECTURE
    
    ┌─────────────────────────────────────────────────────────────┐
    │                                                              │
    │  REMOTE SITE                      CLIENT                    │
    │  ───────────                      ──────                    │
    │                                                              │
    │  ┌─────────┐   ┌─────────┐        ┌─────────┐  ┌─────────┐ │
    │  │ Antenna │──▶│   SDR   │═══════▶│ rtl_tcp │──│ GNU     │ │
    │  └─────────┘   │ Server  │  I/Q   │ Client  │  │ Radio   │ │
    │                └─────────┘  over  └─────────┘  └─────────┘ │
    │                             TCP                             │
    │                              │                              │
    │                              │                              │
    │                        Internet/LAN                         │
    │                                                              │
    └─────────────────────────────────────────────────────────────┘
```

### Remote SDR Options

| Solution | Protocol | Features |
|----------|----------|----------|
| rtl_tcp | TCP | Simple, high bandwidth |
| SpyServer | Proprietary | Lower bandwidth |
| OpenWebRX | HTTP/WebSocket | Browser-based |
| KiwiSDR | Web | Public receivers |
| SoapyRemote | TCP | Multi-device |

### Bandwidth Requirements

| Sample Rate | 8-bit I/Q | 16-bit I/Q |
|-------------|-----------|------------|
| 250 kSPS | 0.5 MB/s | 1 MB/s |
| 1 MSPS | 2 MB/s | 4 MB/s |
| 2 MSPS | 4 MB/s | 8 MB/s |

---

## 🧩 GNU Radio Custom Blocks (OOT)

### Out-of-Tree Module Structure

```
    OOT MODULE STRUCTURE
    
    gr-mymodule/
    ├── CMakeLists.txt
    ├── python/
    │   └── mymodule/
    │       ├── __init__.py
    │       └── my_block.py      ← Python block
    ├── lib/
    │   ├── my_block_impl.cc     ← C++ implementation
    │   └── my_block_impl.h
    ├── include/
    │   └── gnuradio/mymodule/
    │       └── my_block.h       ← Public header
    └── grc/
        └── mymodule_my_block.block.yml  ← GRC definition
```

### Block Types

| Type | Language | Use Case |
|------|----------|----------|
| Sync block | C++/Python | 1:1 I/O ratio |
| Decimator | C++/Python | N:1 ratio |
| Interpolator | C++/Python | 1:N ratio |
| General block | C++/Python | Any I/O ratio |
| Hier block | Python | Composite blocks |

---

*These advanced topics require solid fundamentals.*
