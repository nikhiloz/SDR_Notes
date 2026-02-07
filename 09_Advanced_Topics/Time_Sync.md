# Time Synchronisation for SDR

> Achieving precise timing alignment for coherent reception, TDOA, and networked SDR systems.

---

## 1. Why Time Sync Matters

Precise time synchronisation is critical for:
- **TDOA geolocation**: 1 μs error ≈ 300 m position error
- **Coherent arrays**: samples must align to within a fraction of a wavelength
- **Networked SDR**: distributed receivers need common time reference
- **Timestamping**: accurate event timing for signal analysis

## 2. Time Reference Sources

| Source        | Accuracy        | Cost     | Notes                    |
|---------------|-----------------|----------|--------------------------|
| **GPS PPS**   | ±50 ns          | $15–50   | 1 pulse/sec, needs sky view |
| **GPSDO**     | ±10 ns          | $50–500  | Disciplined oscillator    |
| **NTP**       | ±1–10 ms        | Free     | Network-based, not precise enough for RF |
| **PTP (IEEE 1588)** | ±100 ns  | Moderate | Hardware timestamping     |
| **10 MHz ref**| Phase-locked    | $50+     | Distribution amplifier    |
| **Rubidium**  | ±0.001 ppb      | $100+    | Surplus units available   |

## 3. GPS PPS for SDR

### Setup with RTL-SDR + GPS

```
┌──────────┐     PPS     ┌──────────┐
│ GPS Module│ ──────────► │ Raspberry │ ──── NTP server
│ (u-blox)  │  + NMEA    │ Pi / PC   │      + timestamp
└──────────┘   serial    └─────┬────┘
                               │
                          ┌────▼────┐
                          │  SDR    │
                          │ samples │
                          │ tagged  │
                          └─────────┘
```

```bash
# Install gpsd for GPS handling
sudo apt install gpsd gpsd-clients pps-tools

# Test PPS signal
sudo ppstest /dev/pps0

# Configure chrony for GPS-disciplined NTP
sudo apt install chrony
# Add to /etc/chrony/chrony.conf:
# refclock SHM 0 refid GPS precision 1e-1
# refclock PPS /dev/pps0 refid PPS precision 1e-9
```

### USRP Time Synchronisation

```python
# UHD supports GPS PPS and 10 MHz reference
import uhd

usrp = uhd.usrp.MultiUSRP("type=b200")
usrp.set_clock_source("gpsdo")
usrp.set_time_source("gpsdo")

# Wait for GPS lock
while not usrp.get_mboard_sensor("gps_locked").to_bool():
    time.sleep(1)

# Set time to GPS time
usrp.set_time_next_pps(uhd.types.TimeSpec(int(usrp.get_mboard_sensor("gps_time").to_int())))
```

## 4. TDOA (Time Difference of Arrival)

```
         Signal source (unknown location)
                    ╱│╲
                   ╱ │ ╲
                  ╱  │  ╲
           t₁   ╱   │   ╲  t₃
                ╱    │    ╲
    ┌──────┐  ╱   t₂│     ╲  ┌──────┐
    │ Rx 1 │◄╱      │      ╲►│ Rx 3 │
    └──────┘        │        └──────┘
                ┌───▼───┐
                │ Rx 2  │
                └───────┘

    Δt₁₂ = t₁ - t₂  → hyperbola 1
    Δt₁₃ = t₁ - t₃  → hyperbola 2
    Intersection → source location
```

### Position Error vs Time Error

| Timing error | Position error | Sufficient for       |
|-------------|----------------|----------------------|
| 1 ms        | ~300 km        | Nothing useful       |
| 1 μs        | ~300 m         | City-level           |
| 100 ns      | ~30 m          | Block-level          |
| 10 ns       | ~3 m           | Building-level       |

## 5. Sample-Accurate Alignment

For coherent processing, samples must be aligned precisely:

$$
\Delta n = \Delta t \times F_s
$$

At 2.4 MHz sample rate:
- 1 μs offset = 2.4 sample offset
- Requires fractional sample interpolation for sub-sample alignment

```python
import numpy as np
from scipy.signal import resample

def align_signals(sig1, sig2, fs):
    """Cross-correlate and align two signals"""
    corr = np.correlate(sig1, sig2, mode='full')
    peak = np.argmax(np.abs(corr)) - len(sig2) + 1
    # Integer sample shift
    if peak > 0:
        sig2_aligned = np.pad(sig2, (peak, 0))[:len(sig1)]
    else:
        sig1_aligned = np.pad(sig1, (-peak, 0))[:len(sig2)]
    return sig1, sig2_aligned
```

## 6. Practical Tips

- GPS module with PPS output: u-blox NEO-6M (~$10) is adequate
- For TDOA: all receivers need GPS PPS (or shared ethernet PTP)
- Cable length matching matters for phase-coherent arrays
- Temperature changes cause cable phase shifts (~1°/°C for typical coax)
- GPSDO surplus units (Trimble, Symmetricom) are affordable on eBay

---

**See also**: [Coherent Receivers](Coherent_Receivers.md) | [Frequency Calibration](Frequency_Calibration.md) | [Phased Arrays](Phased_Arrays.md)
