# Phased Arrays & Beamforming

> Using multiple coherent receivers with SDR for direction finding and electronic beam steering.

---

## 1. What Is a Phased Array?

A **phased array** is an antenna system with multiple elements whose signals are
combined with controlled phase offsets to steer the reception (or transmission)
pattern electronically — without physically moving the antenna.

```
                        Wavefront direction
                         ╲  ╲  ╲  ╲  ╲
     ┌───┐  ┌───┐  ┌───┐  ┌───┐
     │ E1│  │ E2│  │ E3│  │ E4│  ← antenna elements
     └─┬─┘  └─┬─┘  └─┬─┘  └─┬─┘
       │ Δφ₁  │ Δφ₂  │ Δφ₃  │
     ┌─┴──────┴──────┴──────┴─┐
     │   Phase Shifter Bank    │
     │   (digital in SDR)      │
     └────────────┬────────────┘
                  │
           ┌──────▼──────┐
           │  Beamformer  │
           │  Σ(weighted) │
           └─────────────┘
```

## 2. Key Concepts

### Steering Angle

$$
\theta = \arcsin\left(\frac{\Delta\phi \cdot \lambda}{2\pi \cdot d}\right)
$$

Where:
- $\Delta\phi$ = phase difference between adjacent elements
- $\lambda$ = wavelength
- $d$ = element spacing (typically λ/2)

### Array Factor

$$
AF(\theta) = \sum_{n=0}^{N-1} w_n \cdot e^{j n k d \sin\theta}
$$

Where $w_n$ = complex weight (amplitude + phase) for element $n$.

### Beamwidth

$$
\theta_{3dB} \approx \frac{0.886 \lambda}{N d \cos\theta_0}
$$

More elements → narrower beam → better angular resolution.

## 3. SDR Phased Array Approaches

### KerberosSDR (4-channel coherent RTL-SDR)

| Feature          | Specification              |
|------------------|----------------------------|
| Channels         | 4 coherent RTL-SDR         |
| Coherent BW      | Up to 2.4 MHz              |
| Frequency        | 24–1766 MHz                |
| Applications     | DoA, passive radar, TDOA   |
| Software         | KrakenSDR DAQ + DoA        |

```bash
# KrakenSDR setup
git clone https://github.com/krakenrf/krakensdr_doa.git
cd krakensdr_doa
./setup.sh
# Requires 4-element antenna array with known geometry
```

### Custom Coherent Setup

```
┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
│ RTL-SDR 1│  │ RTL-SDR 2│  │ RTL-SDR 3│  │ RTL-SDR 4│
└────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘
     │             │             │             │
     └──────┬──────┴──────┬──────┘             │
            │             │                    │
      ┌─────▼─────┐ shared clock (noise source cal)
      │ Coherent   │ ─────────────────────────┘
      │ Processing │
      └───────────┘
```

**Challenge**: RTL-SDR dongles have independent oscillators. Coherence
requires:
- Shared reference clock, or
- Noise-source calibration (transmit known signal to all elements)

## 4. Direction of Arrival (DoA)

### Algorithms

| Algorithm | Complexity | Resolution | Notes                    |
|-----------|-----------|------------|--------------------------|
| **MUSIC** | Medium    | Super-res  | Requires uncorrelated sources |
| **ESPRIT**| Medium    | Super-res  | No steering vector needed|
| **Capon** | Low       | Good       | Minimum variance         |
| **Bartlett**| Lowest  | Limited    | Conventional beamforming |

### MUSIC Algorithm Outline

$$
P_{MUSIC}(\theta) = \frac{1}{\mathbf{a}^H(\theta) \mathbf{E}_n \mathbf{E}_n^H \mathbf{a}(\theta)}
$$

Where $\mathbf{E}_n$ is the noise subspace eigenvectors from the covariance matrix.

## 5. Applications

| Application              | Description                         |
|--------------------------|-------------------------------------|
| Radio direction finding  | Locate transmitter bearing           |
| Passive radar            | Track objects using FM broadcast     |
| Interference nulling     | Steer null towards interferer        |
| TDOA geolocation         | Multilateration with >3 receivers    |
| Radio astronomy          | Aperture synthesis                   |

## 6. Practical Tips

- Start with **2 elements** (simple interferometer) before going to 4+
- Element spacing: **λ/2** eliminates grating lobes
- UCA (Uniform Circular Array) gives 360° coverage; ULA (Uniform Linear) gives 180°
- Calibration is critical — 1° phase error = significant DoA error
- Use a known transmitter location to validate calibration

---

**See also**: [Coherent Receivers](Coherent_Receivers.md) | [DSP Overview](../04_DSP_Fundamentals/DSP_Overview.md)
