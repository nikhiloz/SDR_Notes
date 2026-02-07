# Coherent Receivers

> Achieving phase-coherent multi-channel reception for interferometry, beamforming, and MIMO with SDR.

---

## 1. What Is Coherent Reception?

**Coherent reception** means multiple SDR receivers share the same time and frequency
reference, allowing phase comparisons between channels. This enables direction finding,
beamforming, passive radar, and MIMO processing.

```
                 ┌──────────┐
    Ant 1 ──────►│  SDR 1   │──┐
                 └──────────┘  │
                 ┌──────────┐  │   ┌─────────────┐
    Ant 2 ──────►│  SDR 2   │──┼──►│  Coherent    │
                 └──────────┘  │   │  Processor   │
                 ┌──────────┐  │   └─────────────┘
    Ant 3 ──────►│  SDR 3   │──┘
                 └──────────┘
                      ▲
                      │
              Shared clock / calibration
```

## 2. Requirements for Coherence

| Requirement         | Description                        | Solution                |
|---------------------|------------------------------------|------------------------|
| **Frequency lock**  | All LOs at same frequency          | Shared reference clock  |
| **Phase lock**      | Known phase relationship           | Calibration signal      |
| **Time sync**       | Samples aligned in time            | Shared trigger / PPS    |
| **Stable phase**    | Phase doesn't drift over time      | TCXO / OCXO reference  |

## 3. SDR Hardware Options

### Purpose-Built Coherent SDRs

| Device           | Channels | Bandwidth   | Coherent? | Cost     |
|------------------|----------|-------------|-----------|----------|
| **KrakenSDR**    | 5        | 2.4 MHz     | Yes       | ~$150    |
| **USRP B210**    | 2        | 56 MHz      | Yes       | ~$1,300  |
| **USRP N310**    | 4        | 100 MHz     | Yes       | ~$6,000  |
| **LimeSDR MIMO** | 2        | 61.44 MHz   | Yes       | ~$300    |
| **Pluto+ (rev C)**| 2       | 20 MHz      | Yes       | ~$150    |

### RTL-SDR Coherent Hacks

```
Method 1: Shared oscillator
  - Physically connect one 28.8 MHz crystal to all dongles
  - Requires hardware modification (SMD soldering)
  - Phase offset is constant but unknown → calibrate once

Method 2: Noise source calibration
  - Inject same noise signal into all SDRs
  - Compute cross-correlation to find phase/time offsets
  - Repeat periodically as oscillators drift
```

## 4. Calibration

### Phase Calibration Procedure

```
1. Connect noise source (broadband) to power splitter
2. Split to all N SDR inputs with equal-length cables
3. Record simultaneous samples
4. Cross-correlate channels: Δφ = arg(Σ x₁[n]·x₂*[n])
5. Apply correction: x₂_cal[n] = x₂[n] · e^{-jΔφ}
6. Verify: cross-correlation phase ≈ 0 after correction
```

### Timing Alignment

$$
\tau = \frac{\arg\max(|R_{12}(\tau)|)}{F_s}
$$

Where $R_{12}(\tau)$ is the cross-correlation function between channels.

## 5. Software Frameworks

| Software             | Language | Features                      |
|----------------------|----------|-------------------------------|
| KrakenSDR DAQ       | Python   | Calibration, DoA, passive radar|
| GNU Radio           | C++/Python| Custom flowgraphs             |
| SoapySDR            | C++      | Multi-device abstraction       |
| MATLAB/Octave       | —        | Signal processing, prototyping |

### GNU Radio Multi-Channel Setup

```python
# Simplified GNU Radio flowgraph for 2-channel coherent
import numpy as np
from gnuradio import gr, uhd

# Create 2-channel USRP source
usrp_source = uhd.usrp_source(
    device_addr="type=b200",
    stream_args=uhd.stream_args(cpu_format="fc32", channels=[0, 1])
)
usrp_source.set_clock_source("internal")  # shared clock
usrp_source.set_time_source("internal")   # shared time
```

## 6. Applications

### Passive Radar

```
┌─────────────┐                    ┌─────────┐
│ FM Broadcast │ ──direct path────►│ Ref Ch  │
│ Transmitter  │                   └────┬────┘
└──────┬──────┘                         │
       │ reflected                 ┌────▼────┐
       │ path       ┌────────┐    │ Cross-   │──► Range-Doppler
       └───────────►│ Surv Ch│───►│ Ambiguity│    Map
           Target   └────────┘    └─────────┘
```

Uses FM broadcast (or DVB-T) as "illuminator of opportunity" — track aircraft
and vehicles without transmitting.

### Radio Interferometry

- 2+ antennas with known baseline
- Measure phase difference → angular position
- Resolution: $\theta_{min} \approx \lambda / D$ (baseline $D$)

---

**See also**: [Phased Arrays](Phased_Arrays.md) | [Time Synchronisation](Time_Sync.md) | [Frequency Calibration](Frequency_Calibration.md)
